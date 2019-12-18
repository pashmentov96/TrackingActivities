//
//  LoginView.swift
//  Activities
//
//  Created by Anton Karazeev on 15/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI
import Foundation
import Combine

struct ServerTokenMessage: Decodable {
    let token: String
}

class HttpAuth: ObservableObject {
    var didChange = PassthroughSubject<HttpAuth, Never>()
    
    var authenticated = false {
        didSet {
            didChange.send(self)
        }
    }
    
    func checkDetails(username: String, password: String) {
        guard let url = URL(string: "https://bb084784.ngrok.io/api/tokens") else {return}

        let loginString: String = "\(username):\(password)"
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else { return }
            print("Response: \(String(data: data, encoding: .utf8)!)")
            
            self.authenticated = true
            
//            let finalData = try! JSONDecoder().decode(ServerTokenMessage.self, from: data)
            
//            DispatchQueue.main.async {
//                self.authenticated = true
//            }

            self.authenticated = true
//            print(self.authenticated)
//            print(finalData.token)
            
        }.resume()
    }
}

struct LoginView: View {
    @EnvironmentObject var userData: UserData
    
    @State var httpmanager = HttpAuth()
    
    @State private var username: String = "test_user"
    @State private var password: String = "test"
    
    @State private var passed_password: String = ""
    
    var body: some View {
        VStack {
//            if self.userData.username != "test_user" && self.passed_password != "test" {
            if false {
                AllActivitiesView()
            } else {
                VStack(spacing: 30) {
                    
                    if self.httpmanager.authenticated {
                        Text("authenticated")
                    } else {
                        Text("not authenticated")
                    }
                    
                    TextField("username", text: $username)
                    SecureField("password", text: $password)
                    
                    Button(action: {
                        print("login requested for \(self.username)")
                        
                        self.userData.username = self.username
                        self.passed_password = self.password
                        
                        self.httpmanager.checkDetails(username: self.username, password: self.password)

                        print(self.httpmanager.authenticated)
                    }) {
                        HStack {
                            Text("Let me in").bold()
                        }
                    }
                }.padding()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(UserData())
    }
}
