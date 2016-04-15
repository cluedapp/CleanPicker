//
//  iOS_TopViewController.swift
//
//  Created by Theo Fitchat on 2016-02-01.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(iOS)

    extension UIApplication {

        public class func topViewController (base: UIViewController? = UIApplication.sharedApplication().keyWindow?.rootViewController) -> UIViewController! {

            if let nav = base as? UINavigationController {
                return topViewController(nav.visibleViewController)
            }

            if let tab = base as? UITabBarController {
                let moreNavigationController = tab.moreNavigationController

                if let top = moreNavigationController.topViewController  where top.view.window != nil {
                    return topViewController(top)
                } else if let selected = tab.selectedViewController {
                    return topViewController(selected)
                }
            }

            if let presented = base?.presentedViewController {
                return topViewController(presented)
            }
            
            return base
        }
    }
    
#endif
