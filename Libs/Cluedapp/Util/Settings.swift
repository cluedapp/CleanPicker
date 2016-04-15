//
//  Settings.swift
//
//  Created by Theo Fitchat on 2016/01/14.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import AppKit
#endif

public class Settings {

    public class var all: NSUserDefaults {
        return NSUserDefaults.standardUserDefaults()
    }
    
}
