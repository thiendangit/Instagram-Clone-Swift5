

import Foundation
import UIKit

@objc open class SJShadow: NSObject {
    var offset = CGSize(width: 0, height: 1)
    var color = UIColor.lightGray
    var radius: CGFloat = 3.0
    var opacity: Float = 0.4
    
    /**
     To create a custom shadow object.
     
     - parameter offset:  CGSize, shadow size
     - parameter color:   UIColor, shadow color
     - parameter radius:  CGFloat, shadow radius
     - parameter opacity: Float, shadow opacity
     
     - returns: SJShadow
     */
    public convenience init(offset: CGSize, color: UIColor, radius :CGFloat, opacity: Float) {
        self.init()
        self.offset = offset
        self.color = color
        self.radius = radius
        self.opacity = opacity
    }
    
    /**
     Create light shadow
     
     - returns: light SJShadow object
     */
    open class func light() -> SJShadow {
        return SJShadow(offset: CGSize(width: 0, height: 1),
                        color: UIColor.lightGray,
                        radius: 3.0,
                        opacity: 0.4)
    }
    
    /**
     Create Medium shadow
     
     - returns: medium SJShadow object
     */
    open class func medium() -> SJShadow {
        return SJShadow(offset: CGSize(width: 0, height: 1),
                        color: UIColor.gray,
                        radius: 3.0,
                        opacity: 0.4)
    }
    
    /**
     Create dark shadow
     
     - returns: dark SJShadow object
     */
    open class func dark() -> SJShadow {
        return SJShadow(offset: CGSize(width: 0, height: 1),
                        color: UIColor.black,
                        radius: 3.0,
                        opacity: 0.4)
    }
}
