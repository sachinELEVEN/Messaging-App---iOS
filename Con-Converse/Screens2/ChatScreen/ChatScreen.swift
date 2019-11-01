//
//  ChatScreen.swift
//  Converse
//
//  Created by sachin jeph on 10/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
import Combine




struct PreChatScreen: View {
      @EnvironmentObject var CurrentUser : UserBindableObject
  //Below DataMember will contain Messages by both User(currentUser and the "Other Person")
    @ObservedObject var messagesArray = MessageArray()
     @ObservedObject var messagesArraySelf = MessageArray()
     @ObservedObject var messagesArraySender = MessageArray()
    
    var recepient:messagePerson
    var body: some View {
    
     //This View will load data
           
            
         
        VStack{
            Text("  ")
                .frame(width:0,height:0)
                
                .onAppear{fetchMessageByMe(selfID: self.CurrentUser.id, senderID: self.recepient.phoneNumber){messagesByCurrentUser in
                self.messagesArraySelf.allMessages = messagesByCurrentUser//currentUser is self
                   
                    //Now Retrieving Messages sent by currentUser
                    
                   fetchSenderMessages(selfID:self.CurrentUser.id,senderID:self.recepient.phoneNumber) { (messagesBySender) in
                        //for eachMessageByCurrenUser in messagesByCurrentUser{
                           // self.messagesArray.allMessages.append(eachMessageByCurrenUser)
                   
                        self.messagesArraySender.allMessages = messagesBySender
                        //  for eachMessageByCurrenUser in messagesByCurrentUser{
                            //sorting the messages according to their time
                    
                    self.messagesArray.allMessages = self.messagesArraySelf.allMessages + self.messagesArraySender.allMessages
                    
                            self.messagesArray.allMessages.sort { (mess1, mess2) -> Bool in
                                mess1.date<mess2.date
                            }
                            
                      //  }
                        
                        
                       
                    }
                    
                }
                
                
            }
       
         ChatScreen(recepient: self.recepient,allMessages:self.messagesArray).environmentObject(self.CurrentUser)
        }
        
    }
}





struct ChatScreen: View {
      @EnvironmentObject var CurrentUser : UserBindableObject
    var recepient:messagePerson
    @State var messageToBeSent = ""
    @ObservedObject var allMessages : MessageArray
    //var allMessages : [Message]
    var body: some View {
    
        VStack{
           
            //Message Content
            ScrollView(showsIndicators : false){
                VStack{
                ForEach(allMessages.allMessages,id:\.id){message in
                 
                        ChatBubbleRecepient(message:message)
                  
                   
               
                }
                }.frame(width:fullWidth)
            
        }
           //Spacer()
            
            //Keyboard
            HStack{
                 TextField("Type", text: $messageToBeSent){
                               UIApplication.shared.keyWindow?.endEditing(true)
                           }.frame(height:30)
                               .textFieldStyle(RoundedBorderTextFieldStyle())
                               .font(.title)
                               .padding(.bottom)
               
                Button(action:withAnimation{{self.sendMessage()}}){
                    Image(systemName: "arrow.up.circle.fill")
                        .resizable()
                        .frame(width:30,height:30)
                        .padding(.bottom)
                       
                        
                            
                }
                
            }.padding([.horizontal])
            
        }.navigationBarTitle(recepient.name)
        .navigationBarItems(trailing:
        
        Text("More")
        
        )
    }
    
    func sendMessage(){
        sendMessageToRec(messageToBeSent:self.messageToBeSent,recepient:self.recepient,sender:self.CurrentUser)
       
        //appending the New Message in allMessages
      
        let sentTime = Date()
        let timeInString = formatter.string(from: sentTime)
        let timeInDate = formatter.date(from: timeInString)
        
        let messID = UUID().uuidString
        let newMessage = Message()
        newMessage.text = self.messageToBeSent
        newMessage.id = messID
        newMessage.time = timeInString
        newMessage.date = timeInDate!
        newMessage.isFromSelf = true
        
        allMessages.allMessages.append(newMessage)
        self.messageToBeSent = ""
        //Message Added on screen

        
    }
}

//Done6
