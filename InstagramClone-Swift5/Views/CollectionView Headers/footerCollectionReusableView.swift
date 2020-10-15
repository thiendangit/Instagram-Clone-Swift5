//
//  footerCollectionReusableView.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 10/14/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class footerCollectionReusableView: UICollectionReusableView {
    static let identifier = "footerCollectionReusableView"
    let view : UIView = {
        let v = UIView()
        v.backgroundColor = .red
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(view)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        view.frame = CGRect(x: 0, y: 0, width: view.width , height: photoCollectionViewController.footerHeight)
    }
    
}
