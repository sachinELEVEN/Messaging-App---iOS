//
//  MessageSending.swift
//  Converse
//
//  Created by sachin jeph on 11/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import FirebaseFirestore

func sendMessageToRec(messageToBeSent:String,recepient:messagePerson,sender:UserBindableObject){
    
    let db = Firestore.firestore()
    var allMessages1 = [Message]()
    //print("Message sender")
    let senderID = sender.phoneNumber
    fetchMessages2(recepient: recepient, senderID: senderID) { (messages) in
      
        allMessages1 = messages
         //All Messages of send by  currentUser are there in "allMessages1"
    
   // }
   // print("sending the message")
    //We will create a new message ([String:Any]) and append the message in allMessages1 after downcasting it as? Any
    var AllMessages = [[String:Any]]()
    
    for eachMessage in allMessages1 {
        //Messages already in database
        //so that already have text,time and id
        var singleMessage = [String:Any]()
        singleMessage["text"] = eachMessage.text
         singleMessage["time"] = eachMessage.time
         singleMessage["id"] = eachMessage.id
       // print(singleMessage["id"])
        AllMessages.append(singleMessage)
       // print("Message Appended")
        
    }
   // print("count1",AllMessages.count)
    //creating and Appending newMessage(that users wants to send now) in AllMessages
    
   let sentTime = Date()
    let timeInString = formatter.string(from: sentTime)
        
    let messID = UUID().uuidString
    
    let newMessage : [String:Any] = ["text":messageToBeSent,"time":timeInString,"id":messID]
    
    AllMessages.append(newMessage)
    
     // print("count2",AllMessages.count)
    
       //sending message/Making changes in this senders messages sent field in the recepient's "AllMessages " Dictionary
       
    //Creating a dictionary. So that it can be saved on server
    let newDict : [String:Any] = ["\(senderID)":AllMessages]
   //print(newDict)
    db.collection("Users").document(recepient.id).collection("MessagesRecieved").document("AllMessages").setData(newDict, mergeFields: ["\(senderID)"]) { (error) in
               if error != nil {
                   print("Could not send the message :- ",error!)
               }
               //message sent
               print("Message sent")
        
        //Now Add this Message to your own Collection : "MessageSent" -> Document : "AllMessages"
        saveMessageToSelfDocument(messagesToBeSaved: AllMessages, recepient: recepient, senderID: sender.id)
        
      
        
           }
        
  
    }
    
    
   
}
//Done8


func saveMessageToSelfDocument(messagesToBeSaved:[[String:Any]],recepient:messagePerson,senderID:String){
    
    let db = Firestore.firestore()
  
    let newDict : [String:Any] = ["\(recepient.phoneNumber)":messagesToBeSaved]
   
    //
    db.collection("Users").document(senderID).collection("MessagesSent").document("AllMessages").setData(newDict, mergeFields: ["\(recepient.phoneNumber)"]) { (error) in
               if error != nil {
                   print("Could not send the message :- ",error!)
               }
               //Message Saved
               print("Message Saved to Self Document")
        
      
        
        
           }
        
  
    
    
    
   
}
//done9
