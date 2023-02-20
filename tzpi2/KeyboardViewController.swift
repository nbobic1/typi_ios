//
//  KeyboardViewController.swift
//  tzpi2
//
//  Created by sova on 4. 2. 2023..
//

import UIKit

class KeyboardViewController: UIInputViewController {
        var reverseContent=""
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
   public func rephraseCallback(option:String){
        apiCall(prompt: "Rephrase this text so it sounds more "+option+": ")
    }
    
   public func translateCallback(option:String){
        apiCall(prompt: "Translate this text to "+option+": ")
    }
    @IBAction func reverseBtn(_ sender: Any) {
      
        var a:String=""
        if(self.textDocumentProxy != nil && self.textDocumentProxy.documentContextBeforeInput != nil)
        {
            a=self.textDocumentProxy.documentContextBeforeInput!
        }
        for _ in 0..<a.count {
            self.textDocumentProxy.deleteBackward()
               }
        self.textDocumentProxy.insertText(reverseContent)
    }
    @IBAction func translate(_ sender: Any) {
            let translateView = TranslatePopUp()
                   translateView.appear(sender: self)
    }
    @IBAction func rephrase(_ sender: Any) {
        let rephraseView = RephrasePopUp()
               rephraseView.appear(sender: self)
    }
    @IBAction func help(_ sender: Any) {
        let overLayerView = PopUp()
               overLayerView.appear(sender: self)
    }
    @IBAction func summerize(_ sender: Any) {
        apiCall(prompt: "Summarize this text: ")
    }
    @IBAction func correct_grammar(_ sender: Any) {
        apiCall(prompt: "Correct grammar in this text: ")
    }
    func apiCall(prompt:String)
    {
        
        print("siuuuu "+prompt)
        var a:String=""
        if(self.textDocumentProxy != nil && self.textDocumentProxy.documentContextBeforeInput != nil)
        {
            a=self.textDocumentProxy.documentContextBeforeInput!
        }
        a=prompt+a
        print("a="+a)
        let url = URL(string:"https://api.openai.com/v1/completions")!
        var request = URLRequest(url: url)
        print("kurva")
        request.httpMethod = "POST"
        let userDefaults = UserDefaults(suiteName: "group.etf.tzpi-2.tzpi2")
        let myValue:String = userDefaults!.string(forKey: "Key")!
        print(myValue)
        request.addValue("Bearer \(myValue)", forHTTPHeaderField: "Authorization")
        reverseContent=a
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
        
        self.textDocumentProxy.insertText("wait...")
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
                             for _ in 0..<7 {
                                 self.textDocumentProxy.deleteBackward()
                                    }
                             self.textDocumentProxy.insertText(text)                         }
                         }
                 } catch {
                     print("Error: \(error)")
                 }
                
            }
             }.resume()
     
    }
    @IBAction func dugme(_ sender: Any) {
        apiCall(prompt:	"")
    }
}
