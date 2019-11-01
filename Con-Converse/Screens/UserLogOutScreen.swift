//
//  UserLogOutScreen.swift
//  Converse
//
//  Created by sachin jeph on 31/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

struct UserLogOutScreen: View {
     @EnvironmentObject var CurrentUser : UserBindableObject
    @State var toggleLogOut = false
    @State var toggleRemoveData = false
   // @Binding var ShowSheet : Bool
  
    var body: some View {
        VStack{
        
            if(CurrentUser.isLoggedIn){
            VStack{
                Toggle(isOn : $toggleLogOut){
                    Text("Turn ON the toggle, you will be  logged out")
                    .lineLimit(nil)
                    .padding()
                }
                
                    if(toggleLogOut){
                        
                        Toggle(isOn : $toggleRemoveData){
                                        Text("Turn ON the toggle, all of your messages and other data will be deleted")
                                        .lineLimit(nil)
                                        .padding()
                    }
                        
                }
                  Spacer()
             
                if(toggleLogOut){
                Button(action:{self.userLogOut()}){
                    Text("Done")
                                .fontWeight(.bold)
                              .foregroundColor(.primary)
                             .padding()
                        .frame(width:200)
                             .padding([.horizontal])
                             .background(Color.blue)
                             .cornerRadius(10)
                }
            }
               Spacer()
           
            
            
            }.navigationBarTitle(Text("LogOut Page"))
                .padding()
            
            } else{
                VStack{
                    
                    Text("You Have Been Logged Out")
                    .fontWeight(.heavy)
                    .foregroundColor(.primary)
                    
                    Text("Swipe down and Login/Register ")
                                       .fontWeight(.bold)
                                       .foregroundColor(.secondary)
                                           
                    
                }.navigationBarTitle(Text("Swipe Down"))
                                .padding()
                
                
                
            }
            
        }
    }
    
    
    func userLogOut(){
        
        UserDefaults.standard.removeObject(forKey: "isUserLoggedIn")
        userLoggedIn = false
      //   self.ShowSheet = false
        CurrentUser.isLoggedIn = false
        self.CurrentUser.phoneNumber = "nil"
       
      
     
    }
}


