//
//  MessageSessionCellLayout.swift
//  Converse
//
//  Created by sachin jeph on 10/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
let fullWidth = UIScreen.main.bounds.width
let fullHeight = UIScreen.main.bounds.height

struct MessageSessionCellLayout: View {
         @EnvironmentObject var CurrentUser : UserBindableObject
    var messagePerson : messagePerson
    var body: some View {
       HStack{
                        
                        Image(systemName: "person.fill")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width:50,height: 50)
                            .clipShape(Circle())
                            .onTapGesture {
                                print("Tapped")
                           //     self.CurrentUser.isLoggedIn.toggle()
                    }
                        
                    VStack(alignment:.leading){
                        Text(messagePerson.name)
                                       .fontWeight(.bold)
                       
                        
                                   Text("You were fantastic. Lets do that once more")
                                                    .font(.subheadline)
                
                          }
                 
                   
       }    .frame(width:fullWidth - fullWidth/20)
        .padding(.vertical)
        .foregroundColor(.primary)
                .background(Color.secondary.opacity(0.2))
                .cornerRadius(20)
    }
}

