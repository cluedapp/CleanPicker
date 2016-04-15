//
//  Application.swift
//
//  Created by Theo Fitchat on 2016-04-14.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import AppKit
    typealias Application = NSApplication
    typealias Window = NSWindow
#elseif os(iOS)
    typealias Application = UIApplication
    typealias Window = UIViewController
#endif

public class App {
    class var mainWindow: Window {
        return Application.sharedApplication().mainWindow!
    }
}
