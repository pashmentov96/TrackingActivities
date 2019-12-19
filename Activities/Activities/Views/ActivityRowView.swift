//
//  ActivityRowView.swift
//  Activities
//
//  Created by Anton Karazeev on 16/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI

struct ActivityRowView: View {
    var activity: Activity
    
    var body: some View {
        HStack {
            
            iconView()

            Text(activity.name)
            
            Spacer()
            
            if activity.isfavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }.padding()
    }
    
    func helperIconView() -> some View {
        return activity.image
            .resizable()
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            .shadow(radius: 3)
    }
    
    func iconView() -> AnyView {
        switch activity.difficulty {
        case "easy":
            return AnyView(
                helperIconView()
                    .overlay(Circle().stroke(Color.green, lineWidth: 2))
            )
        case "hard":
            return AnyView(
                helperIconView()
                    .overlay(Circle().stroke(Color.red, lineWidth: 2))
            )
        default:
            return AnyView(Text(""))
       }
    }
}

struct ActivityRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityRowView(activity: activityData[0])
                .previewLayout(.fixed(width: 300, height: 70))
            ActivityRowView(activity: activityData[1])
                .previewLayout(.fixed(width: 300, height: 70))
            ActivityRowView(activity: activityData[3])
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
