//
//  profileImageCollectionViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 10/13/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

protocol profileImageCollectionViewCellDelegate {
    func didTapImage(_ model : UserPostModel)
}

class profileImageCollectionViewCell: UICollectionViewCell {
    static let identifier  = "profileImageCollectionViewCell"
    var model : UserPostModel?
    var delegate : profileImageCollectionViewCellDelegate?
    
    private let profileImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "bell")
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.clipsToBounds = true
        addSubview(profileImageView)
        profileImageView.isUserInteractionEnabled = true
        let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(didTapImage))
        profileImageView.addGestureRecognizer(tapImageGesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapImage(){
        guard let model = model else {
            return
        }
        delegate?.didTapImage(model)
    }
    
    func configure(model : UserPostModel) {
        self.model = model
//        print("images \(model.thumbnailImage[0])")
        profileImageView.sd_setImage(with: model.thumbnailImage[0], completed: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let profileSize = contentView.width
        profileImageView.frame = CGRect(x: 0, y: 0, width: profileSize, height: profileSize)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        profileImageView.backgroundColor = nil
    }
     
}
