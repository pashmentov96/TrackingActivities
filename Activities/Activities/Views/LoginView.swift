//
//  LoginView.swift
//  Activities
//
//  Created by Anton Karazeev on 15/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username: String = ""
    @State private var password: String = ""
    
    @State private var passed_username: String = ""
    @State private var passed_password: String = ""
    
    var body: some View {
        VStack {
            if self.passed_username != "" && self.passed_password != "" {
                ContentView(username: self.username)
            } else {
                VStack(spacing: 30) {
                    TextField("username", text: $username)
                    SecureField("password", text: $password)

                    Button(action: {
                        self.passed_username = self.username
                        self.passed_password = self.password
                        print("login was pressed for \(self.passed_username)")
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
    }
}
