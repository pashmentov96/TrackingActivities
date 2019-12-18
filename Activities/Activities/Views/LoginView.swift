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

struct InputTextField: View {
    @Binding var stringBinding: String
    
    let placeholder: String
    let secureTextField: Bool
    
    var body: some View {
        VStack {
            if secureTextField {
                SecureField(placeholder, text: $stringBinding)
            } else {
                TextField(placeholder, text: $stringBinding)
            }
        }
    }
}

class HttpAuth: ObservableObject {
    @Published var authenticated = false
    @State var token: String = "MOCK_TOKEN"
    
    func checkDetails(username: String, password: String, userData: UserData) {
        guard let url = URL(string: "\(ngrok_url)/api/tokens") else {return}

        let loginString: String = "\(username):\(password)"
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        DispatchQueue.main.async {
            userData.token = "WdxnUke5rX6gXAqSeE/JJDV5GS+Znqt+"
            self.authenticated = true
        }
        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data else { return }
//            print("Response: \(String(data: data, encoding: .utf8)!)")
//
//            let finalData = try! JSONDecoder().decode(ServerTokenMessage.self, from: data)
//
//            DispatchQueue.main.async {
//                userData.token = finalData.token
//                self.authenticated = true
//            }
//
//        }.resume()
        
        print("received token")
    }
}


struct LoginView: View {
    @EnvironmentObject var userData: UserData

    @ObservedObject var httpmanager = HttpAuth()
    
    @State private var username: String = "test_user"
    @State private var password: String = "test"
    
    var body: some View {
        VStack {
            if httpmanager.authenticated {
                AllActivitiesView().environmentObject(userData)
            } else {
                VStack(spacing: 30) {
                    
                    InputTextField(stringBinding: $username, placeholder: "Логин", secureTextField: false)
                    InputTextField(stringBinding: $password, placeholder: "Пароль", secureTextField: true)
                    
                    Button(action: {
                        print("login requested for \(self.username)")
                        self.userData.username = self.username
                        self.httpmanager.checkDetails(username: self.username, password: self.password, userData: self.userData)
                    }) {
                        HStack {
                            Text("Войти").bold()
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
