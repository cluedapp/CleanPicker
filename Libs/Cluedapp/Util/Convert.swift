//
//  Convert.swift
//
//  Created by Theo Fitchat on 2016-01-29.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import Foundation
#endif

extension NSMutableData {

    public func append(string: String) {
        appendData(string.data)
    }

}

extension NSData {

    public var string: String {
        return String(NSString(data: self, encoding: NSUTF8StringEncoding))
    }

}

extension NSString {

    public var data: NSData {
        return self.dataUsingEncoding(NSUTF8StringEncoding)!
    }

}

// Operator overload to convert NSDictionary element to string

infix operator / {
associativity left
precedence 255
}

func / (left: [String : AnyObject], right: String) -> String {
    return String(left[right]!)
}

func / (left: [String : AnyObject], right: Keys) -> String {
    return String(left[right.rawValue]!)
}

// Operator overload to convert NSDictionary element to string array

infix operator % {
associativity left
precedence 255
}

func % (left: [String : AnyObject], right: String) -> [String] {
    return left[right]! as! [String]
}

func % (left: [String : AnyObject], right: Keys) -> [String] {
    return left[right.rawValue]! as! [String]
}

// Operator overload to convert NSDictionary element to hash

infix operator ^ {
associativity left
precedence 255
}

func ^ (left: [String : AnyObject], right: String) -> [String : AnyObject] {
    return left[right]! as! [String : AnyObject]
}

func ^ (left: [String : AnyObject], right: Keys) -> [String : AnyObject] {
    return left[right.rawValue]! as! [String : AnyObject]
}
