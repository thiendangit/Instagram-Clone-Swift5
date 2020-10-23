
import UIKit

class SJUtil {

    /**
     * Method to get topspacing of container,

     - returns: topspace in float
     */
    static func getTopSpacing(_ viewController: UIViewController) -> CGFloat {

        if let _ = viewController.splitViewController {
            return 0
        }

		var topSpacing: CGFloat = 0.0
		let navigationController = viewController.navigationController

        if navigationController?.children.last == viewController {

			if navigationController?.isNavigationBarHidden == false {
                let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
				topSpacing = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
                if !(navigationController?.navigationBar.isOpaque)! {
                    topSpacing += (navigationController?.navigationBar.bounds.height)!
                }
			}
		}
		
        return topSpacing
    }

    /**
     * Method to get bottomspacing of container

     - returns: bottomspace in float
     */
    static func getBottomSpacing(_ viewController: UIViewController) -> CGFloat {

        var bottomSpacing: CGFloat = 0.0

        if let tabBarController = viewController.tabBarController {
            if !tabBarController.tabBar.isHidden && !tabBarController.tabBar.isOpaque {
                bottomSpacing += tabBarController.tabBar.bounds.size.height
            }
        }

        return bottomSpacing
    }
}

extension String {
	
	func widthWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {

		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect,
		                                    options: .usesLineFragmentOrigin,
		                                    attributes: [NSAttributedString.Key.font: font], context: nil)
		return boundingBox.width
	}
}
