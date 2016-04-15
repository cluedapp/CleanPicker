//
//  String.swift
//
//  Created by Theo Fitchat on 2016/01/21.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import Foundation
#endif

extension String {

    // MARK: Trim

    public func trimWhitespace (chars: NSCharacterSet = NSCharacterSet.whitespaceCharacterSet()) -> String {
        return self.stringByTrimmingCharactersInSet(chars)
    }

    public func trim () -> String? {
        do {
            return try NSRegularExpression(pattern: "(?:^\\s+)|(?:\\s+$)", options: .CaseInsensitive).stringByReplacingMatchesInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, length), withTemplate: "$1")
        } catch {
            return nil
        }
    }

    // MARK: Regex

    public func matches (regex: String) -> [String]? {
        do {
            return try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions(rawValue: 0)).matchesInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, length)).map { (self as NSString).substringWithRange($0.range) }
        } catch {
            return nil
        }
    }

    public func isMatch (regex: String) -> Bool {
        return rangeOfString(regex, options: .RegularExpressionSearch) != nil
    }

    public func replace (regex: String, _ with: String) -> String? {
        do {
            return try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions(rawValue: 0)).stringByReplacingMatchesInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, self.length), withTemplate: with)
        } catch {
            return nil
        }
    }

    public func split (regex: String) -> [String]? {
        do {
            var s = self
            var ret = [String]()
            let r = try NSRegularExpression(pattern: regex, options: NSRegularExpressionOptions(rawValue: 0))
            while s != Strings.Empty {
                let match = r.firstMatchInString(s, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, s.length))
                if (match === nil || match!.range.location == NSNotFound) {
                    ret += [s]
                    s = Strings.Empty
                } else {
                    ret += [s.substringToIndex(s.startIndex.advancedBy(match!.range.location))]
                    s = s.substringFromIndex(s.startIndex.advancedBy(match!.range.location + match!.range.length))
                }
            }
            return ret
        } catch {
            return nil
        }
    }

    // MARK: Format

    public func punctuate () -> String {
        var str = trim()!
        if !str.isMatch("[.?!:]$") {
            str += "."
        }
        return str
    }

    public func format (args: CVarArgType...) -> String {
        return String(format: self, locale: nil, arguments: args)
    }

    public var lower: String { return lowercaseString }

    // MARK: Manipulation

    public func substring (index: Int) -> String {
        return substringFromIndex(startIndex.advancedBy(index))
    }
    
    var length: Int { return characters.count }
    
}