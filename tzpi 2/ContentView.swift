//
//  ContentView.swift
//  tzpi 2
//
//  Created by sova on 4. 2. 2023..
//

import SwiftUI

struct ContentView: View {
   @State private var username:String=""
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, !")
            TextField("hehe",text:$username)
            Button(action: {
              // your action here
                print("degen")
                print(username)
                let userDefaults = UserDefaults(suiteName: "group.etf.tzpi-2.tzpi2")
                userDefaults?.set(username, forKey: "Key")
               userDefaults?.synchronize()
                print("myValue7")
            }, label: {
              Text("Unesi api key")
            })
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
