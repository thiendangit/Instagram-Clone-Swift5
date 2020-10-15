//
//  ProfileTabsHeaderCollectionReusableView.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/25/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import XLPagerTabStrip

protocol ProfileTabsHeaderDelegate {
    func profileTabsHeaderDidTapGriButtonTab(_ header : ProfileTabsHeaderViewController)
    func profileTabsHeaderDidTapTaggedButtonTab(_ header : ProfileTabsHeaderViewController)
    func didTapImage(_ model: UserModal)
    func scrollViewDidScroll(scrollView: UIScrollView, collectionView: UICollectionView)
}

class ProfileTabsHeaderViewController: ButtonBarPagerTabStripViewController {
    
    static let identifier = "ProfileTabsHeaderView"
    let heightHeaderTabbar : CGFloat = 60
    var delegateTab : ProfileTabsHeaderDelegate?
    var myPost : [UserModal]?
    var prefPost : [UserModal]?
    
    private var currentPage: Int!
    
    lazy var myPhotoVC : photoCollectionViewController = {
        var vc = photoCollectionViewController(image : UIImage(systemName: "rectangle.split.3x3")!, backgroundColor : .white )
        vc.delegate = self
        return vc
    }()
    
    lazy var prefPhotoVC : photoCollectionViewController = {
        var vc = photoCollectionViewController(image : UIImage(systemName: "tag")!, backgroundColor : .red)
        vc.delegate = self
        return vc
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    func configure(myPost : [UserModal], prefPost : [UserModal] , buttonBarHeight : CGFloat) {
        settings.style.buttonBarHeight = buttonBarHeight
        self.myPost = myPost
        self.prefPost = prefPost
        if let myPost = self.myPost{
            myPhotoVC.config(model: myPost)
        }
        if let prefPost = self.prefPost{
            prefPhotoVC.config(model: prefPost)
        }
        view.backgroundColor = .white
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func addSubView(){
        
    }
    
    override func viewDidLoad() {
        currentPage = 0
        settings.style.buttonBarBackgroundColor = .white
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .black
        settings.style.buttonBarItemFont = .systemFont(ofSize: config.fontSizeDefault)
        settings.style.selectedBarHeight = 1.0
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .black
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarHeight = 60
        changeCurrentIndexProgressive = {(oldCell: ButtonBarViewCell?, newCell: ButtonBarViewCell?, progressPercentage: CGFloat, changeCurrentIndex: Bool, animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.imageView.tintColor = .lightGray
            newCell?.imageView.tintColor = .black
            if animated {
                UIView.animate(withDuration: 0.1, animations: { () -> Void in
                    newCell?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    oldCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
            else {
                newCell?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                oldCell?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }
        }
        
        super.viewDidLoad()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    override public var scrollPercentage : CGFloat {
        containerView.contentOffset.y = 0.0;
        return super.scrollPercentage
    }
    
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child_1 = myPhotoVC
        let child_2 = prefPhotoVC
        return [child_1, child_2]
    }
    
    override func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        if indexWasChanged && toIndex > -1 && toIndex < viewControllers.count {
            let child = viewControllers[toIndex] as! IndicatorInfoProvider // swiftlint:disable:this force_cast
            UIView.performWithoutAnimation({ [weak self] () -> Void in
                guard let me = self else { return }
                me.navigationItem.leftBarButtonItem?.title =  child.indicatorInfo(for: me).title
            })
        }
    }
    
    
    private func addTarget(){
        gridButton.addTarget(self, action: #selector(didTapGriButtonTab), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButtonTab), for: .touchUpInside)
    }
    
    private let gridButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "rectangle.split.3x3"), for: .normal)
        return button
    }()
    
    private let taggedButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .gray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    @objc func didTapGriButtonTab(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .gray
        delegateTab?.profileTabsHeaderDidTapGriButtonTab(self)
    }
    @objc  func didTapTaggedButtonTab(){
        gridButton.tintColor = .gray
        taggedButton.tintColor = .systemBlue
        delegateTab?.profileTabsHeaderDidTapTaggedButtonTab(self)
    }
    
}

extension ProfileTabsHeaderViewController : photoCollectionViewControllerDelegate{
    func didTapImage(_ model: UserModal) {
        print("tab Image profile Tab")
        delegateTab?.didTapImage(model)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView, collectionView: UICollectionView) {
        print("scroll Image")
        delegateTab?.scrollViewDidScroll(scrollView: scrollView, collectionView: collectionView)
    }
}

