//
//  iOS_SetupControls.swift
//
//  Created by Theo Fitchat on 2016-01-28.
//  Copyright © 2016 Cluedapp. All rights reserved.
//

import Foundation

#if os(iOS)

    extension UIResponder {

        public func label (label: UILabel, _ title: String) {
            label.text = title.trim()!.punctuate()
        }

        public func button (button: UIButton, _ title: String) {
            button.setTitle(title, forState: .Normal)
        }

        public func action (view: UIView, _ action: Selector) {
            view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: action))
        }

        public func tap (view: UIView, @autoclosure(escaping) _ handler: () -> ()) {
            class UITapGestureRecognizerWithClosure: UITapGestureRecognizer {

                private var handler: () -> ()

                @objc @IBAction func invoke () {
                    handler()
                }

                init (_ handler: () -> ()) {
                    self.handler = handler

                    // HACK because UITapGestureRecognizer.init cannot take target: self or target: nil so Empty() object required
                    class Empty { }
                    super.init(target: Empty(), action: Selector(Strings.Empty))
                    removeTarget(nil, action: Selector(Strings.Empty))

                    addTarget(self, action: #selector(invoke))
                }

            }

            view.addGestureRecognizer(UITapGestureRecognizerWithClosure(handler))
        }

        public func imageView (imageView: UIImageView, _ url: String, _ force: Bool = false) {
            if !force && imageView.tag > 0 { return }
            imageView.tag = 1
            print("imageView: \(url)")
            Thread.async({
                if let imageData = NSData(contentsOfURL: NSURL(string: url)!) {
                    Thread.ui(imageView.image = UIImage(data: imageData))
                    return
                }
                NSThread.sleepForTimeInterval(5)
                imageView.tag = 0
                self.imageView(imageView, url)
            })
        }

        public func checkbox (checkbox: RTVCheckbox, _ text: String, _ handler: () -> ()) {
            checkbox.text = text
            checkbox.tap(handler)
        }

        public func hyperlink (label: UILabel, _ text: String, @autoclosure(escaping) _ handler: () -> ()) {
            label.attributedText = NSAttributedString(string: text, attributes: [NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle.rawValue])
            label.textColor = Colors.HyperlinkForeground
            tap(label, handler)
        }
        
    }
    
#endif
