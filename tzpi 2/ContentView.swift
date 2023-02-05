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
            Text("Hello, world!")
            TextField("hehe",text:$username)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}