//
//  File.swift
//
//  Created by Theo Fitchat on 2016-04-15.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

import Foundation

extension String {
    public func write (data: String, _ append: Bool = false) {
        do {
            // Append
            if append, let handle = NSFileHandle(forWritingAtPath: self) {
                handle.seekToEndOfFile()
                handle.writeData(data.data)
            } else {
                // Create
                try data.writeToFile(self, atomically: true, encoding: NSUTF8StringEncoding)
            }
        }
        catch { }
    }

    public func read () -> String? {
        do {
            return try NSString(contentsOfFile: self, encoding: NSUTF8StringEncoding) as String
        }
        catch {
            return nil
        }
    }
}
