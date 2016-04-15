//
//  Json.swift
//
//  Created by Theo Fitchat on 2016/01/08.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import Foundation
#endif

public class Json {
    public class func jsonWithDict (obj: [String : AnyObject]) -> String? {
        do {
            // Convert NSDictionary (or AnyObject e.g. NSArray) to NSData
            let data: NSData = try NSJSONSerialization.dataWithJSONObject(obj, options: NSJSONWritingOptions(rawValue: 0))

            // Convert NSData to String
            return data.string
        } catch {
            print("Util.dictToJson: Convert error")
            return nil
        }
    }

    public class func dictWithJson (json: String) -> [String : AnyObject]? {
        do {
            // Convert String to NSData
            let data: NSData = json.data

            // Convert NSData to AnyObject to NSDictionary
            let dict = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers /*NSJSONReadingOptions(rawValue: 0)*/) as! [String : AnyObject]
            return dict
        } catch {
            print("Util.jsonToDict: Convert error")
            return nil
        }
    }
}
