//
//  KeyboardViewController.swift
//  tzpi2
//
//  Created by sova on 4. 2. 2023..
//

import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
      override func updateViewConstraints() {
        super.updateViewConstraints()
        print("ma moye")
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("beyi")
        // Perform custom UI setup here
        self.nextKeyboardButton = UIButton(type: .system)
        
        self.nextKeyboardButton.setTitle(NSLocalizedString("Next Keyboard", comment: "Title for 'Next Keyboard' button"), for: [])
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
        print("ehhh")
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        print("huhhh")
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

    @IBAction func dugme(_ sender: Any) {
        print("siuuuu")
        var a:String=self.textDocumentProxy.documentContextBeforeInput!
        print(a)
        let length = a.count
        let url = URL(string: "https://www.example.com/api/endpoint")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "request_body".data(using: .utf8)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                 print("Error: \(error)")
                 return
             }
             if let data = data {
                 let responseString = String(data: data, encoding: .utf8)
                 print("Response: \(responseString)")
             }
         }.resume()
        for _ in 0..<length {
                    textDocumentProxy.deleteBackward()
                }
        self.textDocumentProxy.insertText("hehe")
    }
}