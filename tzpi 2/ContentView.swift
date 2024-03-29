//
//  ContentView.swift
//  tzpi 2
//
//  Created by sova on 4. 2. 2023..
//

import SwiftUI
import UIKit
import Mixpanel
struct ContentView: View {
   @State private var username:String=""
    var body: some View {
        
        VStack {
            
            Button(action: {
              // your action here
                print("keyboard")
                Mixpanel.initialize(token: "04a8679d9c235e46100327d4f06c43aa", trackAutomaticEvents: true)
                Mixpanel.mainInstance().track(event: "TypiEnable")
               openKeyboardSettings()
            }, label: {
              Text("Step 1: Enable keyboard")
            }).padding(10)
            Text("Step 2: Switch kezboard to Typi and now let's try out the app's functionality :)").padding(10).multilineTextAlignment(.center)
            TextField("Enter your prompt here",text:$username,axis:.vertical).padding(10).multilineTextAlignment(.center)
            Button(action: {
              // your action here
                Mixpanel.initialize(token: "04a8679d9c235e46100327d4f06c43aa", trackAutomaticEvents: true)
                Mixpanel.mainInstance().track(event: "TypiFeedback")
                if let url = URL(string: "https://docs.google.com/forms/d/e/1FAIpQLSfzpb9HiQ9kufdFIPeDRA5-Gs40KDloEcgIH5rjlvPRRN8rxA/viewform") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }, label: {
              Text("Step 3: Make a meaningful impact on our journey! Once you've used Typi, simply fill out our form and help us grow!")
            }).padding(10)
        }
        .padding()
    }
    func openKeyboardSettings() {
       /* guard let settingsURL = URL(string: UIApplication.openSettingsURLString + "&prefs:root=General&path=Keyboard") else {
               return
           }
           
           if UIApplication.shared.canOpenURL(settingsURL) {
               UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
           }*/
        if let url = URL(string: UIApplication.openSettingsURLString + Bundle.main.bundleIdentifier!) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }

        print("probao otvoriti")
       }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
