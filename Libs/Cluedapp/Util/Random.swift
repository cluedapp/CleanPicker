//
//  Random.swift
//
//  Created by Theo Fitchat on 2016-02-20.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import Foundation
#endif

public class Random {
    public class func nextInt (min: UInt32, max: UInt32) -> UInt32 {
        return min + arc4random_uniform(max - min + 1)
    }
}