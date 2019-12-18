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
            VStack(alignment: .leading) {
                HStack {
                    Text(activity.name)
                        .font(.title)
                        .foregroundColor(.green)
                    
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
                
                Text("Distance: \(activity.distance) kilometers")
                Text("Average heartrate: \(activity.heartrate) bpm")
            }.padding()
        }
        .navigationBarTitle(Text(activity.name), displayMode: .inline)
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(activity: activityData[0])
            .environmentObject(UserData())
    }
}
