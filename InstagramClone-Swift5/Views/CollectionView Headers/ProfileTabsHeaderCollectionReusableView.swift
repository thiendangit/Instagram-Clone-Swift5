//
//  ProfileTabsHeaderCollectionReusableView.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/25/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

protocol ProfileTabsHeaderCollectionReusableDelegate : AnyObject {
    func profileTabsHeaderDidTapGriButtonTab(_ header : ProfileTabsHeaderCollectionReusableView)
    func profileTabsHeaderDidTapTaggedButtonTab(_ header : ProfileTabsHeaderCollectionReusableView)
}

class ProfileTabsHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "ProfileTabsHeaderCollectionReusableView"
    
    var delegate : ProfileTabsHeaderCollectionReusableDelegate?
    
    private let gridButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName: "rectangle.split.3x3"), for: .normal)
        return button
    }()
    
    private let taggedButton : UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .gray
        button.setBackgroundImage(UIImage(systemName: "tag"), for: .normal)
        return button
    }()
    
    func configure() {
        
    }
    
    private func addSubView(){
        addSubview(gridButton)
        addSubview(taggedButton)
    }
    
    private func addTarget(){
        gridButton.addTarget(self, action: #selector(didTapGriButtonTab), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTapTaggedButtonTab), for: .touchUpInside)
    }
    
    override func layoutSubviews(){
        super.layoutSubviews()
        let heightSize = height - 10
        let widthSize = ((width/2) - heightSize)/2
        gridButton.frame = CGRect(x: widthSize, y: 5, width: heightSize, height: heightSize)
        taggedButton.frame = CGRect(x: widthSize + width/2, y: 5, width: heightSize, height: heightSize)
    }
    
    override init(frame: CGRect){
        super.init(frame : frame)
        backgroundColor = .brown
        clipsToBounds = true
        addSubView()
        addTarget()
    }
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapGriButtonTab(){
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .gray
        delegate?.profileTabsHeaderDidTapGriButtonTab(self)
    }
    @objc  func didTapTaggedButtonTab(){
        gridButton.tintColor = .gray
        taggedButton.tintColor = .systemBlue
        delegate?.profileTabsHeaderDidTapTaggedButtonTab(self)
    }
    
}

