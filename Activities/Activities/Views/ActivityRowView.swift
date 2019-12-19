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
            Text(activity.name)
            
            Spacer()
            
            if activity.isfavorite {
                Image(systemName: "star.fill")
                    .imageScale(.medium)
                    .foregroundColor(.yellow)
            }
        }.padding()
    }
}

struct ActivityRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ActivityRowView(activity: activityData[0])
                .previewLayout(.fixed(width: 300, height: 70))
            ActivityRowView(activity: activityData[1])
                .previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
