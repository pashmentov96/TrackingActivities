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
            Text("Привет, \(self.userData.username)!")
            
            Text("Кажется, что на этом устройстве пока нет информации о вашей последней активности. Необходимо скачать данные с сервера:")
            
            Button(action: downloadData) {
                Text("Скачать").bold()
            }
            
            Spacer()
        }.padding()
    }
    
    func downloadData() {
        print("downloading")
        
        self.userData.token = "WdxnUke5rX6gXAqSeE/JJDV5GS+Znqt+"
        print("token is \(self.userData.token)")
        
        guard let url = URL(string: "\(ngrok_url)/api/user/get_records") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.setValue("Bearer \(self.userData.token)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data else { return }
//            print("response: \(String(data: data, encoding: .utf8)!)")
//
//            let finalData = try! JSONDecoder().decode([Activity].self, from: data)
//            print("parsed datetime: \(finalData[0].datetime)")
//
//            DispatchQueue.main.async {
//                // self.userData.activities = finalData
//                self.userData.isempty = false
//            }
//
//        }.resume()
        
        print("parsed datetime: \(self.userData.activities[0].datetime)")

        DispatchQueue.main.async {
            self.userData.isempty = false
        }
    }
}

struct EmptyActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyActivitiesView()
            .environmentObject(UserData())
    }
}
