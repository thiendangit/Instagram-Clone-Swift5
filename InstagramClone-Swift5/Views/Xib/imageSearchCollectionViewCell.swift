//
//  imageSearchCollectionViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 10/26/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import AVKit;
import AVFoundation;
import SnapKit

protocol imageSearchCollectionViewCellDelegate {
    func didTapImage(_ model : UserPostModel)
}

class imageSearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "imageSearchCell"
    var model : UserPostModel?
    @IBOutlet weak var playerView: PlayerView!
    var imageCoverContaints: Constraint? = nil
    var delegate : imageSearchCollectionViewCellDelegate?
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .cyan
        return iv
    }()
    
    let imageCoverView : UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        return iv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .white
        self.contentView.addSubview(imageView)
        self.contentView.addSubview(imageCoverView)
        imageView.isUserInteractionEnabled = true
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(handleDidTapImage))
        imageView.addGestureRecognizer(imageTap)
    }
    
    @objc func handleDidTapImage() {
        delegate?.didTapImage(model!)
    }
    
    func configureImage(imageName : String , imageCoverSize : CGFloat){
        imageCoverView.image = UIImage(systemName: imageName)
        imageCoverView.snp.makeConstraints { (make) -> Void in
            make.width.height.equalTo(imageCoverSize)
            make.top.equalTo(5)
            make.right.equalTo(-5)
        }
    }
    
    func configure(model : UserPostModel!, isShowImageCover : Bool, imageCoverSize : CGFloat){
        guard let model = model else {
            return
        }
        contentView.removeConstraints(contentView.constraints)
        self.model = model
        switch model.postType {
        case .photo:
            imageView.sd_setImage(with: model.thumbnailImage.first, completed: nil)
            imageView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(self.contentView)
                make.center.equalTo(self.contentView)
            }
            if(isShowImageCover == true){
                configureImage(imageName : "aspectratio.fill", imageCoverSize: imageCoverSize)
            }
            break
        case .video:
            playerView.frame = bounds
            playerView.isUserInteractionEnabled = true
            let playerTap = UITapGestureRecognizer(target: self, action: #selector(handleDidTapImage))
            playerView.addGestureRecognizer(playerTap)
            let url = NSURL(string: model.videoURL!);
            let avPlayer = AVPlayer(url: url! as URL);
            self.playerView?.playerLayer.player = avPlayer;
            self.playerView?.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            playerView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(self.contentView)
                make.center.equalTo(self.contentView)
            }
            if(isShowImageCover == true){
                configureImage(imageName : "play.fill", imageCoverSize: imageCoverSize)
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.sd_setImage(with: nil, completed: nil)
        imageCoverView.image = nil
        self.playerView?.playerLayer.player?.pause()
    }
}
