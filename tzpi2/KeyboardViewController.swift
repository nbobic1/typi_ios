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
        let url = URL(string:"https://api.openai.com/v1/completions")!
        var request = URLRequest(url: url)
        print("kurva")
        request.httpMethod = "POST"
        let userDefaults = UserDefaults(suiteName: "group.etf.tzpi-2.tzpi2")
        let myValue:String = userDefaults!.string(forKey: "Key")!
        print(myValue)
        request.addValue("Bearer \(myValue)", forHTTPHeaderField: "Authorization")
        
        let json: [String: Any] = [
            
        "model": "text-davinci-003",
        "prompt": "\(a)",
        "max_tokens": 7,
        "temperature": 0.7,
        "frequency_penalty": 0.5]
        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        request.httpBody = jsonData

        request.addValue("application/json", forHTTPHeaderField: "Content-Type");
        for _ in 0..<a.count {
            self.textDocumentProxy.deleteBackward()
               }
        print("obrisano")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            print("moja buducnost")
            if let error = error {
                 print("Error: \(error)")
                 return
             }
            if let data = data {
                
                var responseString1 = String(data: data, encoding: .utf8) ?? " ";
                do {
                            if let data = responseString1.data(using: .utf8),
                         let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                         let choices = json["choices"] as? [[String: Any]] {
                         if let firstChoice = choices.first,
                         let text = firstChoice["text"] as? String {
                         print(text)
                           
                            // self.textDocumentProxy.replace(<#T##UITextRange#>, withText: a)
                                // self.textDocumentProxy.deleteBackward()
                             
                             self.textDocumentProxy.insertText(text)                         }
                         }
                 } catch {
                     print("Error: \(error)")
                 }
                
            }
             }.resume()
     
    }
}
