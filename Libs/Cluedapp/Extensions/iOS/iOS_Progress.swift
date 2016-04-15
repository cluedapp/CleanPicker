//
//  iOS_Progress.swift
//
//  Created by Theo Fitchat on 2016/01/21.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

#if os(iOS)

    class Progress {

        var messageFrame: UIView!
        var indicator: UIActivityIndicatorView!

        private func create (msg: String) {
            if let view = UIApplication.topViewController()?.view {

                messageFrame = UIView(frame: CGRectMake(view.frame.midX - 125, view.frame.midY - 25, 250, 50))
                messageFrame.layer.cornerRadius = 15
                messageFrame.backgroundColor = Colors.AjaxIndicatorBackground

                let strLabel = UILabel(frame: CGRectMake(50, 0, 200, 50))
                strLabel.text = msg
                strLabel.textColor = .blackColor()
                messageFrame.addSubview(strLabel)

                indicator = UIActivityIndicatorView(activityIndicatorStyle: .White)
                indicator.color = .blackColor()
                indicator.frame = CGRectMake(0, 0, 50, 50)
                // indicator.backgroundColor = .whiteColor()
                // indicator.center = viewController.view.center
                messageFrame.addSubview(indicator)

                view.addSubview(messageFrame)
                messageFrame.bringSubviewToFront(view)

                UIApplication.sharedApplication().networkActivityIndicatorVisible = true

            }
        }

        public func show (msg: String) {
            create(msg)
            if let _ = messageFrame, _ = indicator {
                messageFrame.hidden = false
                indicator.startAnimating()
            }
        }

        public func hide () {
            if let _ = messageFrame, _ = indicator {
                indicator.stopAnimating()
                messageFrame.hidden = true
                messageFrame.removeFromSuperview()
            }
        }
        
    }
    
#endif
