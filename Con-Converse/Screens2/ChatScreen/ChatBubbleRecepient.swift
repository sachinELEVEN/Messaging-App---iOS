//
//  ChatBubbleRecepient.swift
//  Converse
//
//  Created by sachin jeph on 11/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI

struct ChatBubbleRecepient: View {
    var message:Message
    var body: some View {
    VStack{
        HStack {
            
            if(message.isFromSelf==true){
                Spacer()}
                
     //   VStack{
            Text(message.text)
                .fontWeight(.bold)
                .lineLimit(nil)
                .padding()
                .background(message.isFromSelf ? Color.secondary.opacity(0.25):Color.purple.opacity(0.7))
                .cornerRadius(20)
                
               // }
            
            if(message.isFromSelf==false){
                           Spacer()}
                
           
         }.padding(.horizontal)
         
        HStack{
            if(message.isFromSelf==true){ Spacer()}
        Text(message.time)
            .font(.caption)
            .foregroundColor(.secondary)
            .padding(.horizontal)
           
             if(message.isFromSelf==false){ Spacer()}
       
        }
        
        }
    }
}
//Done10
