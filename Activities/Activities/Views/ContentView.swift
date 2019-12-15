//
//  ContentView.swift
//  Activities
//
//  Created by Anton Karazeev on 15/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var username: String
    
    var body: some View {
        VStack {
            Text("Hello, \(self.username)!").bold()
            
            Button(action: sendMessage) {
                Text("Press :3")
            }
        }
    }
    
    func sendMessage() {
        let url = URL(string: "http://cf6c869e.ngrok.io/api/Nikita/nrecords")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let jsonDict = try? JSONSerialization.jsonObject(with: data) as? NSDictionary
            print(String(data: data, encoding: .utf8)!)
//            let parsed_url: String = jsonDict?["origin"] as! String
            print(jsonDict ?? "asdasd")
            print("LOL")
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(username: "Test")
    }
}
