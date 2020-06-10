//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Guest User on 6/9/20.
//  Copyright © 2020 eaic. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    @IBOutlet var testShortcutButton: UIButton!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Perform custom UI setup here
        
        self.testShortcutButton = UIButton(type: .system)
        
        self.testShortcutButton.setTitle(NSLocalizedString("Run Shortcut", comment: "Run a shortcut."), for: [])
        self.testShortcutButton.sizeToFit()
        self.testShortcutButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.testShortcutButton.addTarget(self, action: #selector(runShortcut), for: .touchUpInside)
        
        self.view.addSubview(self.testShortcutButton)
        
        self.testShortcutButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.testShortcutButton.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("🌐", comment: "Switch to the next keyboard."), for: [])
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        self.nextKeyboardButton.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.nextKeyboardButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true

    }
    
    override func viewWillLayoutSubviews() {
        self.nextKeyboardButton.isHidden = !self.needsInputModeSwitchKey
        super.viewWillLayoutSubviews()
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }
     @objc func runShortcut(){
        linkOpener(l: URL(string: "shortcuts://x-callback-url/run-shortcut?x-success=shortkey-callback:callback&name="+("Test".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!))!)
    }
    // For skip compile error.
    @objc func openURL(_ url: URL) {
        return
    }

    func linkOpener( l: URL) {
        var responder: UIResponder? = self as UIResponder
        let selector = #selector(openURL(_:))
        while responder != nil {
            if responder!.responds(to: selector) && responder != self {
                responder!.perform(selector, with: l)
                return
            }
            responder = responder?.next
        }
    }

}
