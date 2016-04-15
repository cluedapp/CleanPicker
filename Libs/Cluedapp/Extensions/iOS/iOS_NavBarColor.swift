//
//  iOS_NavBarColor.swift
//
//  Created by Theo Fitchat on 2016-01-28.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(iOS)

    extension UINavigationBar {

        public class var backgroundColor: UIColor {
            // Remember to adjust "Translucent" boolean property on "Storyboard - Navigation Controller - Navigation Bar - Attributes Inspector", for each navigation controller
            get { return appearance().barTintColor! }
            set { appearance().barTintColor = newValue }
        }

        public class var titleColor: UIColor? {
            get { return appearance().titleTextAttributes?[NSForegroundColorAttributeName] as? UIColor }
            set { if let value = newValue { appearance().titleTextAttributes = [NSForegroundColorAttributeName: value] } }
        }

        /*
         do {
             // Navigation bar tint color set globally in AppDelegate.swift

             // iOS 7.0 or later
             navigationController.navigationBar.barTintColor = Colors.NavigationBar
             navigationController.navigationBar.translucent = false

             // iOS 6.1 or earlier
             navigationController.navigationBar.tintColor = Colors.NavigationBar
             }
         */
        
    }
    
#endif
