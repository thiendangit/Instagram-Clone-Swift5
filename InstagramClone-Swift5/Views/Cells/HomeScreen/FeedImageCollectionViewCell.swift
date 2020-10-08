//
//  FeedImageCollectionViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 10/8/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class FeedImageCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var imgView: EEZoomableImageView!
    
    override func awakeFromNib() {
           super.awakeFromNib()
       }
       
       func configure(image: UIImage){
//           self.imgView.image = image
       }
       
}
