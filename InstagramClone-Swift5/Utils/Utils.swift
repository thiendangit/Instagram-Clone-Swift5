//
//  Utils.swift
//  InstagramClone-Swift5
//
//  Created by Thiện Đăng on 9/24/20.
//  Copyright © 2020 Thiện Đăng. All rights reserved.
//

import Foundation
import UIKit


class Utils {
    static let shared = Utils()
    func AlertCustom(title : String ,message : String , arrayActions : [UIAlertAction], target: UIViewController, preferredStyle : UIAlertController.Style) {
        let alert = UIAlertController(title: "\(title)", message: message , preferredStyle: preferredStyle)
        for arrayAction in arrayActions {
            alert.addAction(arrayAction)
        }
        if preferredStyle == .actionSheet {
            alert.popoverPresentationController?.sourceView = target.view
            alert.popoverPresentationController?.sourceRect = target.view.bounds
        }
        target.present(alert, animated: true)
    }
    
    let textFileCornerRadius : CGFloat = 8.0
}

extension String {
    func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}


