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

class imageSearchCollectionViewCell: UICollectionViewCell {
    static let identifier = "imageSearchCell"
    var model : UserPostModel?
    @IBOutlet weak var playerView: PlayerView!
    
    let imageView : UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .cyan
        return iv
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.backgroundColor = .white
    }
    
    func configure(model : UserPostModel!){
        guard let model = model else {
            return
        }
        contentView.removeConstraints(contentView.constraints)
        self.model = model
        switch self.model?.postType {
        case .photo:
            self.contentView.addSubview(imageView)
            imageView.sd_setImage(with: model.thumbnailImage.first, completed: nil)
            imageView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(self.contentView)
                make.center.equalTo(self.contentView)
            }
        case .video:
            playerView.frame = bounds
            let url = NSURL(string: model.videoURL!);
            let avPlayer = AVPlayer(url: url! as URL);
            self.playerView?.playerLayer.player = avPlayer;
            self.playerView?.playerLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            playerView.snp.makeConstraints { (make) -> Void in
                make.width.height.equalTo(self.contentView)
                make.center.equalTo(self.contentView)
            }
        default :
            return
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        switch self.model?.postType {
        case .photo:
            imageView.sd_setImage(with: nil, completed: nil)
        case .video:
            self.playerView.player?.pause();
            return
        default :
            return
        }
    }
}
