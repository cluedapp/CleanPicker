//
//  OSX_Alert.swift
//
//  Created by Theo Fitchat on 2016-04-14.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)

    import AppKit

    extension NSViewController {
        public func alert(msg: String, _ title: String = Strings.Message, closure: (() -> ())? = nil) {
            let alert = NSAlert()
            alert.messageText = title.trim()!
            alert.informativeText = msg.trim()!.punctuate()
            alert.addButtonWithTitle(Strings.OK)
            alert.alertStyle = .WarningAlertStyle
            alert.runModal()
            if let closure = closure { closure() }
        }

        /*
         public func alertAsync(msg: String, _ title: String = Strings.Message, closure: (() -> ())? = nil) {
         let alert = NSAlert()
         alert.messageText = title.trim()!
         alert.informativeText = msg.trim()!.punctuate()
         alert.addButtonWithTitle(Strings.OK)
         alert.alertStyle = .WarningAlertStyle
         alert.beginSheetModalForWindow(App.mainWindow, completionHandler: { _ in if let closure = closure { closure() } })
         }
         */
    }

#endif