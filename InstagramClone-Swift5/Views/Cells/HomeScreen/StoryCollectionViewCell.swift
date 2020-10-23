//
//  StoryCollectionViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 10/7/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import SnapKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "StoryCell"
    
    var imgView: UIImageView!
    var nameLbl: UILabel!
    var view : UIView!
    
    var button: UIButton = {
        let button = UIButton()
        return button
    }()
    var user: User?
    
    var imageViewWidth : CGFloat = 60
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view = UIView()
        imgView = UIImageView()
        
        self.contentView.addSubview(view)
        view.snp.makeConstraints({make in
            make.width.height.equalTo(imageViewWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo(5)
        })
        view.layer.cornerRadius = imageViewWidth / 2
        view.backgroundColor = .black
        view.addSubview(imgView)
        
        imgView.snp.makeConstraints({make in
            make.width.height.equalTo(imageViewWidth)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(0)
        })
        imgView.layer.cornerRadius = imageViewWidth / 2
        imgView.backgroundColor = .systemTeal
        
        nameLbl = UILabel()
        nameLbl.translatesAutoresizingMaskIntoConstraints = false
        nameLbl.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        nameLbl.text = "username"
        self.contentView.addSubview(nameLbl)
        nameLbl.snp.makeConstraints({make in
            make.width.equalToSuperview()
            make.height.equalTo(11)
            make.centerX.equalToSuperview()
            make.top.equalTo(imgView.snp.bottom).offset(8)
        })
    }
    
    func configurecCurrentUser(user: User){
        imgView.sd_setImage(with:  user.thumbnailImage, completed: nil)
        imgView.layer.masksToBounds = true
        
        nameLbl.text = "Tin của bạn"
        button.backgroundColor = .systemBlue
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = imageViewWidth/3/2
        view.addSubview(button)
        button.snp.makeConstraints({
            make in
            make.width.height.equalTo(imageViewWidth/3)
            make.top.left.equalTo((imageViewWidth-imageViewWidth/3.2))
        })
        view.snp.updateConstraints { (make) -> Void in
            make.width.height.equalTo(imageViewWidth)
            make.centerX.equalToSuperview()
            make.top.equalTo((10))
        }
    }
    //
    func configure(user: User){
        let contants : CGFloat = 5
        self.imgView.sd_setImage(with:  user.thumbnailImage, completed: nil)
        imgView.layer.masksToBounds = true
        view.backgroundColor = .purple
        view.snp.updateConstraints { (make) -> Void in
            make.width.height.equalTo(imageViewWidth+contants)
            make.centerX.equalToSuperview()
            make.top.equalTo(10)
        }
        self.nameLbl.text = user.username
        imgView.snp.updateConstraints({make in
            make.width.height.equalTo(imageViewWidth)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(contants/2)
        })
    }
    //
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgView.sd_setImage(with:  nil, completed: nil)
        self.nameLbl.text = nil
        button.backgroundColor = nil
        button.setImage(nil, for: .normal)
        button.layer.borderColor = nil
        button.layer.borderWidth = 0
        imgView.clipsToBounds = false
        view.backgroundColor = nil
    }
}
