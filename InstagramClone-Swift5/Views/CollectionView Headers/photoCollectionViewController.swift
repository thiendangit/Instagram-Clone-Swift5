//
//  photoCollectionViewController.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 10/13/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import Foundation
import UIKit
import XLPagerTabStrip

protocol photoCollectionViewControllerDelegate {
    func didTapImage(_ model : UserModal)
    func scrollViewDidScroll(scrollView: UIScrollView, collectionView: UICollectionView)
    func scrollViewDidInit(collectionView: UICollectionView)
}

class photoCollectionViewController : UIViewController, IndicatorInfoProvider {
    static let itemSize = UIScreen.main.bounds.width/3
    static let footerHeight = CGFloat(70.0)
    var model : [UserModal]?
    var delegate : photoCollectionViewControllerDelegate?
    var collectionView : UICollectionView!{
        didSet{
            collectionView.delegate = self
            collectionView.dataSource = self
        }
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(image: image)
    }
    
    var image : UIImage = UIImage()
    var backgroundColor : UIColor?
    
    required init(image : UIImage, backgroundColor : UIColor) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = backgroundColor
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: photoCollectionViewController.itemSize-4/3, height: photoCollectionViewController.itemSize-4/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 1
        // Do any additional setup after loading the view.
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.contentInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        collectionView.register(profileImageCollectionViewCell.self, forCellWithReuseIdentifier: profileImageCollectionViewCell.identifier)
        collectionView.register(footerCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: footerCollectionReusableView.identifier)
        collectionView.bounces = false
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.tag = 0
        collectionView.showsVerticalScrollIndicator = false
        guard let collectionViewCopy = collectionView else { return }
        view.addSubview(collectionViewCopy)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = CGRect(x: 0, y: 0, width: view.width, height:  view.height)
        delegate?.scrollViewDidInit(collectionView: collectionView)
    }
    
    func config(model : [UserModal]){
        self.model = model
    }
    
}

extension photoCollectionViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: profileImageCollectionViewCell.identifier, for: indexPath) as! profileImageCollectionViewCell
        cell.delegate = self
        cell.configure(model: model![indexPath.row])
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: footerCollectionReusableView.identifier, for: indexPath)
            footerView.backgroundColor = UIColor.green
            return footerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.scrollViewDidScroll(scrollView: scrollView, collectionView: collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.width , height: photoCollectionViewController.footerHeight )
    }
}

extension photoCollectionViewController : profileImageCollectionViewCellDelegate{
    func didTapImage(_ model: UserModal) {
        delegate?.didTapImage(model)
    }
}
