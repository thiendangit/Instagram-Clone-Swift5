//
//  noNotificationView.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/29/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import Foundation
import UIKit
public class NoNotificationView : UIView {
    var label:UILabel = {
        let label = UILabel()
        label.text = "You don't have any notification!"
        label.textColor = UIColor.black
        label.numberOfLines = 1
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    var imageView : UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFit
        image.tintColor = .black
        image.backgroundColor = .white
        return image
    }()
    
    override init (frame : CGRect) {
        super.init(frame : frame)
        clipsToBounds = true
        imageView.image = UIImage(systemName:"bell")
        self.addSubview(imageView)
        self.addSubview(label)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (width-100)/2, y: 0, width: 100 , height: 100).integral
        label.frame = CGRect(x: 0, y: imageView.bottom, width: width, height: height-100).integral
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
