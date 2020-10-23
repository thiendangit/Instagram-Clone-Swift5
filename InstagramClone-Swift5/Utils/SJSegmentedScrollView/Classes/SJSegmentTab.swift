

import Foundation
import UIKit
import SnapKit

typealias DidSelectSegmentAtIndex = (_ segment: SJSegmentTab?,_ index: Int,_ animated: Bool) -> Void

open class SJSegmentTab: UIView {

	let kSegmentViewTagOffset = 100
	let button = UIButton(type: .custom)

	var didSelectSegmentAtIndex: DidSelectSegmentAtIndex?
	var isSelected = false {
		didSet {
			button.isSelected = isSelected
		}
	}

	convenience init(title: String) {
		self.init(frame: CGRect.zero)
        setTitle(title)
	}

	convenience init(view: UIView) {
		self.init(frame: CGRect.zero)
		insertSubview(view, at: 0)
		view.removeConstraints(view.constraints)
		addConstraintsToTitleView(view)
	}

	required override public init(frame: CGRect) {
		super.init(frame: frame)

		translatesAutoresizingMaskIntoConstraints = false
		button.frame = bounds
		button.addTarget(self, action: #selector(SJSegmentTab.onSegmentButtonPress(_:)),
		                 for: .touchUpInside)
		addSubview(button)
		addConstraintsToView(button)
	}
    
    func addConstraintsToTitleView(_ view: UIView){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.snp.makeConstraints({ make in
            make.width.height.equalTo(30)
            make.center.equalToSuperview()
        })
    }

	func addConstraintsToView(_ view: UIView) {

		view.translatesAutoresizingMaskIntoConstraints = false
		let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|",
		                                                         options: [],
		                                                         metrics: nil,
		                                                         views: ["view": view])
		let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|",
		                                                           options: [],
		                                                           metrics: nil,
		                                                           views: ["view": view])
		addConstraints(verticalConstraints)
		addConstraints(horizontalConstraints)
	}

	required public init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
    
    open func setTitle(_ title: String) {
        
        button.setTitle(title, for: .normal)
    }

	open func titleColor(_ color: UIColor) {

		button.setTitleColor(color, for: .normal)
	}
    
    open func selectedTitleColor(_ color: UIColor?) {
        
        button.setTitleColor(color, for: .selected)
    }

	open func titleFont(_ font: UIFont) {

		button.titleLabel?.font = font
	}

	@objc func onSegmentButtonPress(_ sender: AnyObject) {
		let index = tag - kSegmentViewTagOffset
		NotificationCenter.default.post(name: Notification.Name(rawValue: "DidChangeSegmentIndex"),
		                                object: index)
        didSelectSegmentAtIndex?(self, index, true)
	}
}
