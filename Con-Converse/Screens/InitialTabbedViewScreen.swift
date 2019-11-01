//
//  InitialTabbedView.swift
//  Converse
//
//  Created by sachin jeph on 31/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
//struct PreInitialTabbedView: View {
//    //var isLoggedIn : Bool
//    var body: some View {
//    InitialTabbedView()
//    }
//}




struct InitialView: View {
    @EnvironmentObject var CurrentUser : UserBindableObject
    var body: some View {
        VStack{
            //VStack{
           // Text("s")
            PreHomeScreen().environmentObject(self.CurrentUser)
//              .tabItem {
//                  VStack{
//                      Image(systemName: "bubble.left.and.bubble.right.fill")
//                      Text("Messages")
//                  }
//              }.tag(0)
//
//        UserLogOutScreen().environmentObject(CurrentUser)//Later add this screen into settings page
//              .tabItem {
//                              VStack{
//                                  Image(systemName: "gear")
//                                  Text("Settings")
//                              }
//        }.tag(1)//if user is not logged in, he cannot go into settings
          }
    }
}

