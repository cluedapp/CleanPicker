//
//  OpenExternal.swift
//
//  Created by Theo Fitchat on 2016-02-07.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import AppKit
    import Foundation
#endif

extension NSResponder {

    public func url (url: String) {
        #if os(OSX)
            NSWorkspace().openURL(NSURL(string: url)!)
        #elseif os(iOS)
            UIApplication.sharedApplication().openURL(NSURL(string: url)!)
        #endif
    }

    #if os(iOS)
    public func phone (number: String) {
        self.url("tel://\(number)")
    }
    #endif

    public func email (email: String) {
        self.url("mailto:\(email)")
    }
    
}
