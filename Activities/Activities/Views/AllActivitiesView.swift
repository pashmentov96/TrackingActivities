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
    
    var body: some View {
        VStack {
            if self.userData.isempty {
                EmptyActivitiesView().environmentObject(userData)
            } else {
                ActivityListView().environmentObject(userData)
            }
        }
    }
    
//    @ViewBuilder
//    var body: some View {
//        if userData.isempty {
//            EmptyActivitiesView().environmentObject(UserData())
//        } else {
//            ActivityListView().environmentObject(UserData())
//        }
//    }

}

struct AllActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AllActivitiesView()
            .environmentObject(UserData())
    }
}
