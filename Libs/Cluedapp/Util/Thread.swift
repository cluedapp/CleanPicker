//
//  Thread.swift
//
//  Created by Theo Fitchat on 2016-02-02.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(OSX)
    import Foundation
#endif

public class Thread {

    public class func async(closure: () -> ()) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), closure)
    }
    
    public class func ui(@autoclosure(escaping) closure: () -> ()) {
        dispatch_async(dispatch_get_main_queue()) {
            closure()
        }
    }

}
