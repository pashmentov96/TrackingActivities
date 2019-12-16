//
//  ActivitySimpleView.swift
//  Activities
//
//  Created by Anton Karazeev on 15/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI

struct ActivitySimpleView: View {
    
    var activity: Activity
    
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("\(self.activity.name)")
            Text("\(self.activity.datetime)")
        }
    }
}

struct ActivitySimpleView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitySimpleView(activity: activityData[0])
    }
}
