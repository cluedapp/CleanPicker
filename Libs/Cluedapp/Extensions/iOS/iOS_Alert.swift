//
//  iOS_Alert.swift
//
//  Created by Theo Fitchat on 2016/01/21.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(iOS)

    // MARK: Variables

    private var _alertHandlers: [(() -> ())?]!

    extension UIResponder {

        public func alertView (alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
            if _alertHandlers.count > buttonIndex && _alertHandlers[buttonIndex] != nil {
                _alertHandlers[buttonIndex]?()
            }
        }

        public func alert (title: String, _ msg: String, _ handler: (() -> ())? = nil) {
            alertWithOptions(title, msg, [Strings.OK], [handler])
        }

        public func alertWithOKCancel (title: String, _ msg: String, _ ok: (() -> ())? = nil, cancel: (() -> ())? = nil) {
            alertWithOptions(title, msg, [Strings.OK, Strings.Cancel], [ok, cancel])
        }

        public func alertWithOptions (title: String, _ msg: String, _ options: [String], _ alertHandlers: [(() -> ())?]) {
            _alertHandlers = alertHandlers

            let alert = UIAlertView()
            alert.delegate = self
            alert.title = title.trim()!
            alert.message = msg.trim()!.punctuate()
            for option in options {
                alert.addButtonWithTitle(option)
            }
            alert.show()
        }
    }

    extension UIViewController {
        @available(iOS 8.0, *)
        public func alertWithOKCancelIOS8 (title: String, _ msg: String, _ ok: (UIAlertAction) -> () = { _ in }, _ cancel: (UIAlertAction) -> () = { _ in }) {
            let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)

            alertController.addAction(UIAlertAction(title: Strings.OK, style: .Default, handler: ok))
            alertController.addAction(UIAlertAction(title: Strings.Cancel, style: .Default, handler: cancel))
            
            showVC(alertController)
        }
        
    }
    
#endif
