//
//  FormTableViewCell.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/25/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import UIKit

protocol FormTableViewCellDelegate {
    func handleOnChangeValue(_ cell : FormTableViewCell ,data : EditProfileFormModal)
}

class FormTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    public var delegate : FormTableViewCellDelegate?
    
    static let identifier = "FormTableViewCell"
    
    private let formLabel  : UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let textField : UITextField = {
        let textField = UITextField()
        textField.returnKeyType = .done
        return textField
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(textField)
        textField.delegate = self
    }
    
    public func configure(formData : EditProfileFormModal){
        formLabel.text = formData.lable
        textField.placeholder = formData.placeHolder
        textField.text = formData.value
    }
    
    public override func prepareForReuse() {
        formLabel.text = nil
        textField.placeholder = nil
        textField.text = nil
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 5, y: 0, width: contentView.width/4, height: contentView.height)
        textField.frame = CGRect(x: formLabel.right + 5, y: 0, width: contentView.width - formLabel.width - 15, height: contentView.height)
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.handleOnChangeValue(self, data: EditProfileFormModal(lable: formLabel.text ?? "", placeHolder: textField.placeholder ?? "" , value: textField.text ?? ""))
        textField.resignFirstResponder()
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
