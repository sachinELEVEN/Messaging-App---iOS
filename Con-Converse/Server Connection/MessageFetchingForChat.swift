//
//  MessageFetchingForChat.swift
//  Converse
//
//  Created by sachin jeph on 10/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import FirebaseFirestore

func fetchSenderMessages(selfID:String,senderID:String,completion:@escaping (_ allMessages:[Message])->()){
  print("ID is")
    print(senderID)
    
    var hasRecievedMessages = false
    
    let db = Firestore.firestore()
    print("self id is ",selfID)
    //check the document "AllMessages" of self user and not the recepient
   // let id = "9x2yCC7cSpag7c0IhrpYmA8jwT52"
    
    //Below due to this we are getting a single document read as we have direct //reference to the document
       //Khudke Document pe ja rhe hai
    db.collection("Users").document(selfID).collection("MessagesRecieved").document("AllMessages").addSnapshotListener { (docSnapshot, error) in
        if error != nil{
            print("Error_5 :-",error!)
        }
        
        //if   let docData = docSnapshot?.data(){
    //   print("Val is")
     //   print(docSnapshot?.data())
        if let docDict = docSnapshot?.data() as? [String:Any]{
            
           print("sender id is ")
            print(senderID)
        if  let sentMessagesFromSender = docDict["\(senderID)"] as? [Any]{//stored as an Array on firestore so downcast Any
          
             //Note :- Do not assign large numbers in firestore field names
            
             //All Messages are stored in messageArray
             var messagesArray  = [Message]()
             
             for eachMessage1 in sentMessagesFromSender{

             if let eachMessage = eachMessage1 as? [String:Any]
             {
                
             
                     let message = Message()
                    
                     guard let id = eachMessage["id"] as? String else{return}
                     guard let text = eachMessage["text"] as? String else{return}
                     guard let time = eachMessage["time"] as? String else{return}
                 message.id = id
                 message.text = text
                     message.time = time
          
                message.date = formatter.date(from:message.time)!
                
                    
            
                print("Important")
                print(message.text)
                     messagesArray.append(message)
                 
                // }
                 //All Message Data filled in messagesArray
                 
                 
             }
         }
             
            // print("Array is")
            // print(messagesArray)
            // print(messagesArray.count)
             print("Original ",messagesArray.count)
            hasRecievedMessages = true
             completion(messagesArray)
             
        // }
             
         }
    }


    }
    
    if(!hasRecievedMessages){
         let emptymessagesArray  = [Message]()
        completion(emptymessagesArray)
    }
    
    ///
    /*
    db.collection("Users").document(recepient.id).collection("MessagesRecieved").getDocuments{ (snapshot, error) in
       //due to this we are getting a single document read as we have direct reference to the document
        if error != nil{
                 print("Error in fetching Messages :-",error!)
                 
             }
        for doc in snapshot!.documents{
         //message should also have an date and time
          //  print(doc.data())
       // if let messageData1 = documentSnapshot!.data(){
         //   if let name = doc.data()["name"] as? String{print("name is ",name)}
           // print("SENDER ID",senderID)
        if let allMessages1 = doc.data()["\(senderID)"] as? [Any]{//stored as an Array on firestore so downcast Any
         
            //Note :- Do not assign large numbers in firestore field names
           
            //All Messages are stored in messageArray
            var messagesArray  = [Message]()
            
            for eachMessage1 in allMessages1{

            if let eachMessage = eachMessage1 as? [String:Any]
            {
               
            
                    let message = Message()
                   
                    guard let id = eachMessage["id"] as? String else{return}
                    guard let text = eachMessage["text"] as? String else{return}
                    guard let time = eachMessage["time"] as? String else{return}
                    message.text = text
                    message.time = time
                    message.id = id
                    messagesArray.append(message)
                
               // }
                //All Message Data filled in messagesArray
                
                
            }
        }
            
           // print("Array is")
           // print(messagesArray)
           // print(messagesArray.count)
            print("Original ",messagesArray.count)
            completion(messagesArray)
            
       // }
            
        }
        }
    }
    ///
 */
    
    
}



///////// For Sending Messages
func fetchMessages2(recepient:messagePerson,senderID:String,completion:@escaping (_ allMessages:[Message])->()){
    let db = Firestore.firestore()
   
    print("RecepientID",recepient.id)
       //Samne wale ke Document pe ja rhe hai
    db.collection("Users").document(recepient.id).collection("MessagesRecieved").getDocuments{ (snapshot, error) in
          //due to this we are getting a single document read as we have direct reference to the document( i mean here we have a direct reference to a Collection which as of now contains only 1 Document)
        if error != nil{
                 print("Error in fetching Messages :-",error!)
                 
             }
       
        if(snapshot?.documents.count != 0){
            //Users has recieved Messages previously from this sender or some other sender
            //means "AllMessages" document already exits for this recepient
        for doc in snapshot!.documents{
            
            //message should also have an date and time
          //  print(doc.data())
       // if let messageData1 = documentSnapshot!.data(){
         //   if let name = doc.data()["name"] as? String{print("name is ",name)}
           // print("SENDER ID",senderID)
            
            //if previously both users have shared messages
        if let allMessages1 = doc.data()["\(senderID)"] as? [Any]{//stored as an Array on firestore so downcast Any
         
            //Note :- Do not assign large numbers in firestore field names
           
            //All Messages are stored in messageArray
            var messagesArray  = [Message]()
            
            for eachMessage1 in allMessages1{

            if let eachMessage = eachMessage1 as? [String:Any]
            {
               
            
                    let message = Message()
                   
                    guard let id = eachMessage["id"] as? String else{return}
                    guard let text = eachMessage["text"] as? String else{return}
                    guard let time = eachMessage["time"] as? String else{return}
                    message.text = text
                    message.time = time
                    message.id = id
                    messagesArray.append(message)
                
               // }
                //All Message Data filled in messagesArray
                
                
            }
        }
            
           // print("Array is")
           // print(messagesArray)
           // print(messagesArray.count)
            print("Original ",messagesArray.count)
            completion(messagesArray)
            
       // }
            
        }else{
            //if first message is being sent to the recepient from this user
            let messagesArray = [Message]()
            completion(messagesArray)
            }
        }
    }else{//Users has NEVER recieved any Messages previously from anyone
        //means "AllMessages" document does not exists exits for this recepient
            //Now we will need to add the "AllMessages" document for this recepient
            let docID = UUID().uuidString
            let newData : [String:Any] = ["id":docID]
            db.collection("Users").document(recepient.id).collection("MessagesRecieved").document("AllMessages").setData(newData)
            print("Document Created with new DocID")
        
    }
        
    }
    
    
}







func fetchMessageByMe(selfID:String,senderID:String,completion:@escaping (_ allMessages:[Message])->()){
    //selfID is CurrentUser's id
    //senderID is the PhoneNumber of the "Other Person" in chat
    
    
        let db = Firestore.firestore()
       
        print("selfID",selfID)
    
    //Khudke Document pe ja rhe hai
    db.collection("Users").document(selfID).collection("MessagesSent").getDocuments{ (snapshot, error) in
          
        //due to this we are getting a single document read as we have direct reference to the document( i mean here we have a direct reference to a Collection which as of now contains only 1 Document)
           
        if error != nil{
                     print("Error in fetching Messages :-",error!)
                     
                 }
           
            if(snapshot?.documents.count != 0){
                
                //Users has recieved Messages previously from this sender or some other sender
                //means "AllMessages" document already exits for this recepient
            for doc in snapshot!.documents{
                
                //message should also have an date and time
              //  print(doc.data())
           // if let messageData1 = documentSnapshot!.data(){
             //   if let name = doc.data()["name"] as? String{print("name is ",name)}
               // print("SENDER ID",senderID)
                
                //if previously both users have shared messages
            if let allMessages1 = doc.data()["\(senderID)"] as? [Any]{//stored as an Array on firestore so downcast Any
             
                //Note :- Do not assign large numbers in firestore field names
               
                //All Messages are stored in messageArray
                var messagesArray  = [Message]()
                
                for eachMessage1 in allMessages1{

                if let eachMessage = eachMessage1 as? [String:Any]
                {
                   
                
                        let message = Message()
                       
                        guard let id = eachMessage["id"] as? String else{return}
                        guard let text = eachMessage["text"] as? String else{return}
                        guard let time = eachMessage["time"] as? String else{return}
                        message.text = text
                        message.time = time
                        message.date = formatter.date(from: message.time)!
                        message.id = id
                        message.isFromSelf = true
                        messagesArray.append(message)
                    
                   // }
                    //All Message Data filled in messagesArray
                    
                    
                }
            }
                
               // print("Array is")
               // print(messagesArray)
               // print(messagesArray.count)
                print("MessagesSentByCurrentUser ",messagesArray.count)
                completion(messagesArray)
                
           // }
                
            }else{
                //if first message is being sent to the recepient from this user
                //return an empty array in completion handler
                let messagesArray = [Message]()
                completion(messagesArray)
                }
            }
        }else{//Users has NEVER recieved any Messages previously from anyone
            //means "AllMessages" document does not exists exits for this recepient
                //Now we will need to add the "AllMessages" document for this recepient
                let docID = UUID().uuidString
                let newData : [String:Any] = ["id":docID]
                db.collection("Users").document(selfID).collection("MessagesSent").document("AllMessages").setData(newData)
                print("Document Created with new DocID")
            
        }
            
        }
        
        
    
    
    
    
}














//Done8


//STARTS NOW
/*
 func fetchMessageByMe(selfID:String,senderID:String,completion:@escaping (_ allMessages:[Message])->()){
     //selfID is CurrentUser's id
     //senderID is the PhoneNumber of the "Other Person" in chat
     
     
         let db = Firestore.firestore()
        
         print("selfID",selfID)
     
     //Khudke Document pe ja rhe hai
     db.collection("Users").document(selfID).collection("MessagesSent").getDocuments{ (snapshot, error) in
           
         //due to this we are getting a single document read as we have direct reference to the document( i mean here we have a direct reference to a Collection which as of now contains only 1 Document)
            
         if error != nil{
                      print("Error in fetching Messages :-",error!)
                      
                  }
            
             if(snapshot?.documents.count != 0){
                 
                 //Users has recieved Messages previously from this sender or some other sender
                 //means "AllMessages" document already exits for this recepient
             for doc in snapshot!.documents{
                 
                 //message should also have an date and time
               //  print(doc.data())
            // if let messageData1 = documentSnapshot!.data(){
              //   if let name = doc.data()["name"] as? String{print("name is ",name)}
                // print("SENDER ID",senderID)
                 
                 //if previously both users have shared messages
             if let allMessages1 = doc.data()["\(senderID)"] as? [Any]{//stored as an Array on firestore so downcast Any
              
                 //Note :- Do not assign large numbers in firestore field names
                
                 //All Messages are stored in messageArray
                 var messagesArray  = [Message]()
                 
                 for eachMessage1 in allMessages1{

                 if let eachMessage = eachMessage1 as? [String:Any]
                 {
                    
                 
                         let message = Message()
                        
                         guard let id = eachMessage["id"] as? String else{return}
                         guard let text = eachMessage["text"] as? String else{return}
                         guard let time = eachMessage["time"] as? String else{return}
                         message.text = text
                         message.time = time
                         message.id = id
                         message.isFromSelf = true
                         messagesArray.append(message)
                     
                    // }
                     //All Message Data filled in messagesArray
                     
                     
                 }
             }
                 
                // print("Array is")
                // print(messagesArray)
                // print(messagesArray.count)
                 print("MessagesSentByCurrentUser ",messagesArray.count)
                 completion(messagesArray)
                 
            // }
                 
             }else{
                 //if first message is being sent to the recepient from this user
                 //return an empty array in completion handler
                 let messagesArray = [Message]()
                 completion(messagesArray)
                 }
             }
         }else{//Users has NEVER recieved any Messages previously from anyone
             //means "AllMessages" document does not exists exits for this recepient
                 //Now we will need to add the "AllMessages" document for this recepient
                 let docID = UUID().uuidString
                 let newData : [String:Any] = ["id":docID]
                 db.collection("Users").document(selfID).collection("MessagesSent").document("AllMessages").setData(newData)
                 print("Document Created with new DocID")
             
         }
             
         }
         
         
     
     
     
     
 }
 */
