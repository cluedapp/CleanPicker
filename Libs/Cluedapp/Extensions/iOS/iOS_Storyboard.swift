//
//  iOS_Storyboard.swift
//
//  Created by Theo Fitchat on 2016/01/08.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(iOS)

    extension UIViewController {

        public class func getVC (from: UIViewController!, _ storyboard: String, _ viewControllerID: String) -> UIViewController? {

            let sb = storyboard == Strings.Empty ? from.storyboard! : UIStoryboard(name: storyboard, bundle: nil)
            let vc = viewControllerID == Strings.Empty ? sb.instantiateInitialViewController() : sb.instantiateViewControllerWithIdentifier(viewControllerID)

            vc?.modalTransitionStyle = NSModalTransitionStyle.FlipHorizontal

            return vc
        }

        public func showVC (vc: UIViewController) {
            presentViewController(vc, animated: true, completion: nil)
        }

        public func dismissVC (completion: (() -> ())? = nil) {
            dismissViewControllerAnimated(true, completion: completion)
        }

        public func modal (identifier: String) {
            segue(identifier)
        }

        public func segue (identifier: String) {
            performSegueWithIdentifier(identifier, sender: self)
        }

        public func forceStoryboardWithNoNavController (storyboard: String = Strings.Empty, _ viewControllerID: String = Strings.Empty) {
            if let vc = ViewControllerType.getVC(self, storyboard, viewControllerID) {
                showVC(vc)
            }
        }

        /*
         public func gotoStoryboard (fromViewController: UIViewController, storyboard: String = Strings.Empty, _ viewControllerID: String = Strings.Empty) {
         let vc = getVC(storyboard, viewControllerID)!

         let nc = fromViewController.navigationController!
         nc.pushViewController(vc, animated: true)
         }

         @available(iOS 8.0, *)
         public func gotoStoryboard2 (storyboard: String = Strings.Empty, _ viewControllerID: String = Strings.Empty) {
         let vc = getVC(storyboard, viewControllerID)

         self.showViewController(vc, sender: self)
         }

         // Same end result as forceStoryboardWithNoNavController, just different way to achieve it
         public func forceStoryboardWithNoNavController2 (storyboard: String = Strings.Empty, _ viewControllerID: String = Strings.Empty) {
         let vc = getVC(storyboard, viewControllerID)

         let window = UIApplication.sharedApplication().windows[0] as UIWindow
         UIView.transitionFromView(
         window.rootViewController!.view,
         toView: vc.view,
         duration: 0.65,
         options: .TransitionCrossDissolve,
         completion: {
         finished in window.rootViewController = vc
         })
         }

         public func forceStoryboardWithNewNavController (storyboard: String = Strings.Empty, _ viewControllerID: String = Strings.Empty) {
         let vc = getVC(storyboard, viewControllerID)!

         let nc = ViewControllerType(rootViewController: vc)
         self.presentViewController(nc, animated: true, completion: nil)
         }
         */

    }

#endif
