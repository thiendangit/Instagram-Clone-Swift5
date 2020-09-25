//
//  ProfileViewController..swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var CollectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        ConfigureNavigationTabBar()
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: view.width/3, height: view.width/3)
        CollectionView?.dataSource = self
        CollectionView?.delegate = self
        CollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height), collectionViewLayout: layout)
        guard let collectionView = CollectionView else {
            return
        }
        view.addSubview(collectionView)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        CollectionView?.frame = view.bounds
    }
    
    func ConfigureNavigationTabBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrow.left.square"), style: .done, target: self, action: #selector(onPressLogout))
        navigationItem.rightBarButtonItem?.tintColor = UIColor.black
    }
    
    @objc func onPressLogout() -> Void {
        let vcSetting = SettingViewController()
        vcSetting.modalPresentationStyle = .fullScreen
        vcSetting.title = "Settings"
        self.navigationController?.pushViewController(vcSetting, animated: true)
    }
}

extension ProfileViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell(frame: .zero)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
}
