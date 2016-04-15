//
//  HexColor.swift
//
//  Created by Theo Fitchat on 2016/01/19.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import AppKit
#endif

extension Color {
    public convenience init? (_ hex: String) {
        var cString = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString

        if cString.hasPrefix("#") {
            cString = (cString as NSString).substringFromIndex(1)
        }

        if cString.characters.count != 8 {
            cString += "FF"
        }

        if cString.characters.count != 8 {
            return nil
        }

        var rgbValue: UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)

        self.init(
            red: CGFloat((rgbValue & 0xFF000000) >> 24) / 255.0,
            green: CGFloat((rgbValue & 0x00FF0000) >> 16) / 255.0,
            blue: CGFloat((rgbValue & 0x0000FF00) >> 8) / 255.0,
            alpha: CGFloat(rgbValue & 0x000000FF) / 255.0
        )
    }
}

