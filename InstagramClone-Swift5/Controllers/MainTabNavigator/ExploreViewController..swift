//
//  ExploreViewController..swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//


import UIKit

class ExploreViewController: UIViewController {
    var headerSearchCollectionView : [headerItemExploreModal] = [headerItemExploreModal]()
    @IBOutlet weak var headerSearchView: headerSearchView!
    @IBOutlet weak var collectionViewHeader: UICollectionView!{
        didSet{
            collectionViewHeader.delegate = self
            collectionViewHeader.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibHeaderSearchCell = UINib(nibName: "headerSearchCollectionViewCell", bundle:nil)
        collectionViewHeader.register(nibHeaderSearchCell, forCellWithReuseIdentifier: headerSearchCollectionViewCell.identifier)
        if let flowLayout = collectionViewHeader?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        headerSearchCollectionView.append(headerItemExploreModal(image: "tv", label: " IGTV"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "music.house", label: " Store"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "", label: "Travel"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "", label: "Structure"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "", label: "Decor"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "", label: "art"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "", label: "cuisine"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "", label: "Structure"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "", label: "Decor"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "", label: "art"))
        headerSearchCollectionView.append(headerItemExploreModal(image: "", label: "cuisine"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerSearchView.configure()
    }
    
}

extension ExploreViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return headerSearchCollectionView.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: headerSearchCollectionViewCell.identifier , for: indexPath) as! headerSearchCollectionViewCell
        cell.configure(model: headerSearchCollectionView[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

