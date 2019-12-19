//
//  ActivityDetailView.swift
//  Activities
//
//  Created by Anton Karazeev on 16/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI

struct ActivityDetailView: View {
    @EnvironmentObject var userData: UserData
    var activity: Activity
    
    var activityIndex: Int {
        userData.activities.firstIndex(where: { $0.id == activity.id })!
    }
    
    var body: some View {
        VStack {
            
            activity.image
                .resizable()
                .frame(width: 150, height: 150)
                .shadow(radius: 3)
                .offset(y: -200)
                .padding(.bottom, -200)
            
            HStack {
                Text(activity.name)
                    .font(.title)
                    .foregroundColor(.orange)
                
                Button(action: {
                    self.userData.activities[self.activityIndex].isfavorite.toggle()
                }) {
                    if self.userData.activities[self.activityIndex].isfavorite {
                        Image(systemName: "star.fill")
                            .foregroundColor(Color.yellow)
                    } else {
                        Image(systemName: "star")
                            .foregroundColor(Color.gray)
                    }
                }
            }

            HStack {
                Text("Расстояние: \(activity.distance) км")
                Text("•")
                Text("Время: \(activity.time / 60):\(String(format: "%02d", activity.time % 60))")
            }
            
            HStack {
                ImageStore.shared.image(name: "heartrate")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .shadow(radius: 3)
                Text("\(activity.heartrate) bpm")
            }
            
            HStack {
                Text("Это было:")
                difficultyView()
            }

        }.padding().navigationBarTitle(Text(activity.name), displayMode: .inline)
    }
    
    func difficultyView() -> AnyView {
        switch activity.difficulty {
        case "easy":
            return AnyView(Text("Легко").foregroundColor(.green).bold())
        case "hard":
            return AnyView(Text("Тяжело").foregroundColor(.red).bold())
        default:
            return AnyView(Text(""))
       }
    }
    
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: activityData[3])
            .environmentObject(UserData())
    }
}
