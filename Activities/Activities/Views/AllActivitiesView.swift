//
//  AllActivitiesView.swift
//  Activities
//
//  Created by Anton Karazeev on 16/12/19.
//  Copyright © 2019 Anton Karazeev. All rights reserved.
//

import SwiftUI

struct AllActivitiesView: View {
    @EnvironmentObject var userData: UserData
    
    @ViewBuilder
    var body: some View {
        if userData.isempty {
            EmptyActivitiesView()
        } else {
            ActivityListView()
        }
    }

}

struct AllActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AllActivitiesView()
            .environmentObject(UserData())
    }
}
