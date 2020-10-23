

import UIKit

class SJContentView: UIScrollView {
    
    var pageIndex = 0
    var contentViews = [UIView]()
    var contentView: UIView!
    var contentViewWidthConstraint: NSLayoutConstraint!
    var contentSubViewWidthConstraints = [NSLayoutConstraint]()
    let animationDuration = 0.3
    var didSelectSegmentAtIndex: DidSelectSegmentAtIndex?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
		isPagingEnabled = true
        
        contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[contentView]|",
                                                                                   options: [],
                                                                                   metrics: nil,
                                                                                   views: ["contentView": contentView!, "mainView": self])
        addConstraints(horizontalConstraints)
        
        contentViewWidthConstraint = NSLayoutConstraint(item: contentView!,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: nil,
                                                        attribute: .notAnAttribute,
                                                        multiplier: 1.0,
                                                        constant: 0)
        addConstraint(contentViewWidthConstraint)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[contentView(==mainView)]|",
                                                                                 options: [],
                                                                                 metrics: nil,
                                                                                 views: ["contentView": contentView!, "mainView": self])
        addConstraints(verticalConstraints)
    }
    
    func addContentView(_ view: UIView, frame: CGRect) {
        
        view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(view)
        
        let width = Int(frame.size.width)
        if contentViews.count > 0 {
            
            let previousView = contentViews.last
            let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[previousView]-0-[view]",
                                                                                       options: [],
                                                                                       metrics: ["xPos": (contentViews.count * width)],
                                                                                       views: ["view": view, "previousView": previousView!])
            contentView.addConstraints(horizontalConstraints)
        } else {
            
            let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]",
                                                                                       options: [],
                                                                                       metrics: ["xPos": (contentViews.count * width)],
                                                                                       views: ["view": view])
            contentView.addConstraints(horizontalConstraints)
        }
        
        let widthConstraint = NSLayoutConstraint(item: view,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1.0,
                                                 constant: CGFloat(width))
        contentView.addConstraint(widthConstraint)
        contentSubViewWidthConstraints.append(widthConstraint)
        
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[view]-0-|",
                                                                                 options: [],
                                                                                 metrics: nil,
                                                                                 views: ["view": view])
        contentView.addConstraints(verticalConstraints)
        contentViews.append(view)
        
        contentViewWidthConstraint.constant = CGFloat(contentViews.count) * bounds.width
    }
    
    func updateContentControllersFrame(_ frame: CGRect) {
        
        let width = frame.size.width
        contentViewWidthConstraint.constant = CGFloat(contentViews.count) * width
        
        for constraint in contentSubViewWidthConstraints {
            constraint.constant = width
        }
        
        layoutIfNeeded()
        var point = contentOffset
        if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
            let newIndex = (contentViews.count - pageIndex) - 1
            point.x = CGFloat(newIndex) * width
        } else {
            point.x = CGFloat(pageIndex) * width
        }
        
        setContentOffset(point, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func movePageToIndex(_ index: Int, animated: Bool) {
        
        pageIndex = index
        var point = CGPoint.zero
        if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
            let newIndex = (contentViews.count - index) - 1
            point = CGPoint(x: (newIndex * Int(bounds.size.width)), y: 0)
        } else {
            point = CGPoint(x: (index * Int(bounds.size.width)), y: 0)
        }
    
        if animated == true {
            UIView.animate(withDuration: animationDuration) {
                self.contentOffset = point
            }
        } else {
            contentOffset = point
        }
    }
}

extension SJContentView: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageIndex = Int(contentOffset.x / bounds.size.width)
        if UIView.userInterfaceLayoutDirection(for: self.semanticContentAttribute) == .rightToLeft {
            pageIndex = (contentViews.count - 1) - pageIndex
        }
        didSelectSegmentAtIndex?(nil, pageIndex, true)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "DidChangeSegmentIndex"),
                                        object: pageIndex)
    }
}
