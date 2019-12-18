//
//  EmptyActivitiesView.swift
//  Activities
//
//  Created by Anton Karazeev on 16/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI

struct EmptyActivitiesView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack {
            Text("Hello, \(self.userData.username)!").bold()
            
            Button(action: updateEmpty) {
                Text("Update")
            }
        }
    }
    
    func updateEmpty() {
        userData.isempty = false
        print(userData.isempty)
    }
    
    func sendMessage() {
        let url = URL(string: "http://cf6c869e.ngrok.io/api/Nikita/nrecords")!
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            let jsonDict = try? JSONSerialization.jsonObject(with: data) as? NSDictionary
            print(String(data: data, encoding: .utf8)!)
            // let parsed_url: String = jsonDict?["origin"] as! String
            print(jsonDict ?? "asdasd")
            print("LOL")
        }
        task.resume()
    }
}

struct EmptyActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyActivitiesView()
            .environmentObject(UserData())
    }
}
