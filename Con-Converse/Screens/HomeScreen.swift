//
//  HomeScreen.swift
//  Converse
//
//  Created by sachin jeph on 31/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

struct PreHomeScreen: View {
      @EnvironmentObject var CurrentUser : UserBindableObject
   // var a : Int?
   // @State var loggedIn  = false// Bool?
    var body: some View {
            VStack{
                
                if(!CurrentUser.isLoggedIn){
                    UserSignUpScreen().environmentObject(self.CurrentUser)}
        
               else{
                    HomeScreen().environmentObject(self.CurrentUser) }
                
                 
            }.onAppear{print("Val is",self.CurrentUser.isLoggedIn)}
    }
    
}


struct HomeScreen: View {
     @EnvironmentObject var CurrentUser : UserBindableObject
    @State var ShowSheet : Bool = false
    var body: some View {
      
        NavigationView{
            VStack{
                ScrollView(.vertical) {
                    if(self.CurrentUser.messagePersonBag.count==0){
               Text("Search and Message \nSimple.")
                                     .fontWeight(.heavy)
                                     .font(.title)
                .multilineTextAlignment(.center)}
                    else{
                       //Add Message Sessions Here
                        ForEach(self.CurrentUser.messagePersonBag,id: \.id){person in
                           
                            NavigationLink(destination:PreChatScreen(recepient: person).environmentObject(self.CurrentUser)){
                            MessageSessionCellLayout(messagePerson: person).environmentObject(self.CurrentUser)
                                
                            }
                            
                        }
                    }
                }
                
                .sheet(isPresented: $ShowSheet){
                    SettingsScreen(ShowSheet :self.$ShowSheet).environmentObject(self.CurrentUser)
            }

            
            }.navigationBarTitle(Text("Home"))
                .navigationBarItems(trailing:
                
                    NavigationLink(destination:SearchScreen().environmentObject(self.CurrentUser)){
                    
                            Text("Search")
                   
                    }
                
                )
            .gesture(
                    DragGesture(minimumDistance: 50)
                        .onEnded { _ in
                            print("Dragged!")
                            self.ShowSheet = true
                        }
                )
        }
    }
}


