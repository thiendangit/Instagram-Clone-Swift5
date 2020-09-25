//
//  ExploreViewController..swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//


import UIKit

class ExploreViewController: UIViewController {

    var searchBar : UISearchBar? = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .secondarySystemBackground
        
        return searchBar
    }()
    
    var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.titleView = searchBar
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // Do any additional setup after loading the view.
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        guard let collectionViewCopy = collectionView else { return }
        view.addSubview(collectionViewCopy)
    }
    
}

extension ExploreViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
}

