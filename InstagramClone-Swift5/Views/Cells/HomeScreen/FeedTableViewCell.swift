//
//  FeedTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 10/7/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit
import ReadMoreTextView

class FeedTableViewCell: UITableViewCell {
    
    //headerPost
    @IBOutlet weak var profileSectionView: UIView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    //ImageView
    @IBOutlet weak var imageCollectionView: UICollectionView!{
        didSet{
            
        }
    }
    //Actions View
    @IBOutlet weak var heartButton: UIButton!
    
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var tagButton: UIButton!
    
    @IBOutlet weak var pageControl: UIPageControl!{
        didSet{
            pageControl.numberOfPages = 3
            pageControl.pageIndicatorTintColor = .systemGray
            pageControl.currentPageIndicatorTintColor = .systemBlue
        }
    }
    //detais Post View
    @IBOutlet weak var numberOfLikeLbl: UILabel!
    
    @IBOutlet weak var readMoreTextView: ReadMoreTextView!
    
    @IBOutlet weak var seeMoreMessageLbl: UILabel!{
        didSet{
            //            let tap = UITapGestureRecognizer(target: self, action: #selector(DetailViewController.tapFunction))
            seeMoreMessageLbl.isUserInteractionEnabled = true
            //            seeMoreMessageLbl.addGestureRecognizer(tap)
        }
    }
    
    //footer Post View
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var imageFooterView: UIImageView!
    @IBOutlet weak var heartFooterButton: UIImageView!
    @IBOutlet weak var handFooterButton: UIImageView!
    @IBOutlet weak var moreMessageFooterButton: UIButton!
    @IBOutlet weak var plusFooterButton: UIImageView!
    @IBOutlet weak var timePostLbl: UILabel!
    
    //configure cell
    func configure(){
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        readMoreTextView.onSizeChange = {_ in }
        readMoreTextView.shouldTrim = true
    }
}
