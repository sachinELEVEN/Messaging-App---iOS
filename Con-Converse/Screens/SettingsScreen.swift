//
//  SettingsScreen.swift
//  Converse
//
//  Created by sachin jeph on 01/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

struct SettingsScreen: View {
     @EnvironmentObject var CurrentUser : UserBindableObject
    @Binding var ShowSheet : Bool

    var body: some View {
    NavigationView{
        VStack{
        List{
                Section{
                NavigationLink(destination: UserLogOutScreen().environmentObject(self.CurrentUser)){
                    HStack{
                        Image(systemName: "person.crop.circle.fill")
                        Text("Account Details")
                        Spacer()
                    }}
            
            
            }
            
        }.listStyle(GroupedListStyle())
        
        
        }.navigationBarTitle("Settings")
    }
    
    }
}

