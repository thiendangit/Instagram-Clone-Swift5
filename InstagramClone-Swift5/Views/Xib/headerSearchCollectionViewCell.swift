//
//  headerSearchCollectionViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 10/23/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

class headerSearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "headerSearchCell"
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        InitConfigure()
    }
    
    func configure(model : headerItemExploreModal!){
        guard let model = model else {
            return
        }
        if (model.image != "") {
            button.setImage(UIImage(systemName: model.image ?? ""), for: .normal)
            button.setTitle(model.label, for: .normal)
        }else{
            button.setImage(nil, for: .normal)
            button.setTitle(model.label, for: .normal)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button.setTitle(nil, for: .normal)
        button.setImage(nil, for: .normal)
    }
    
    func InitConfigure(){
        contentView.layer.cornerRadius = 5
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
    }
}
