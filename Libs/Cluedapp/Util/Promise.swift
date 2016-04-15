//
//  Promise.swift
//
//  Created by Theo Fitchat on 2016-02-11.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

public class Promise<ThenType, FailType> {
    private var thenClosures: [ThenType]!
    private var failClosures: [FailType]!
    private var alwaysClosures: [() -> ()]!
    private var _resolved: Bool?
    private var resolved: Bool? {
        get { return _resolved }
    }

    private var iocBefore: (() -> ())!
    private var iocThen: (ThenType -> ())!
    private var iocFail: (FailType -> ())!
    private var iocAlways: ((() -> ()) -> ())!

    public init () {
        setup()
    }

    public func ioc (iocBefore: () -> (), _ iocThen: ThenType -> (), _ iocFail: FailType -> (), _ iocAlways: (() -> ()) -> ()) {
        (self.iocBefore, self.iocThen, self.iocFail, self.iocAlways) = (iocBefore, iocThen, iocFail, iocAlways)
    }

    public func then (closure: ThenType) -> Promise {
        thenClosures! += [closure]
        if let resolved = _resolved where resolved { go() }
        return self
    }

    public func fail (closure: FailType) -> Promise {
        failClosures! += [closure]
        if let resolved = _resolved where !resolved { go() }
        return self
    }

    public func always (closure: () -> ()) -> Promise {
        alwaysClosures! += [closure]
        if let _ = _resolved { go() }
        return self
    }

    public func resolve () -> Promise {
        if let _ = _resolved {
            return self
        }
        _resolved = true
        go()
        return self
    }

    public func reject () -> Promise {
        if let _ = _resolved {
            return self
        }
        _resolved = false
        go()
        return self
    }

    private func setup () {
        (thenClosures, failClosures, alwaysClosures) = ([], [], [])
    }

    private func go () {
        if let resolved = _resolved {

            iocBefore()

            if resolved {
                for closure in thenClosures {
                    iocThen(closure)
                }
            } else {
                for closure in failClosures {
                    iocFail(closure)
                }
            }

            for closure in alwaysClosures {
                iocAlways(closure)
            }

            setup()
        }
    }
}
