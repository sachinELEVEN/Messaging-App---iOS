
//
//  Data Model.swift
//  Converse
//
//  Created by sachin jeph on 01/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserBindableObject : ObservableObject{
   
    //Data Members
 @Published   var isLoggedIn : Bool = false//when this data member changes any View using this class instance will be notified
  @Published   var phoneNumber : String = ""
    @Published var messagePersonBag = [messagePerson]()
    var id = ""
    var messagesRecievedDocRef = "AllMessages"
    
   //Member Functions
    public  func AddToMessagePersonBag(personDict : [String:Any]){
      let idL = personDict["id"] as! String
        let nameL = personDict["name"] as! String
         let phoneNumberL = personDict["phoneNumber"] as! String
// let profileImageL = personDict["profileImage"] as! String //This is not available in Database as of now
            let profileImageL = "profileImage.url"
         let docRefL = personDict["id"] as! String
       
        
        let newPerson = messagePerson(id: idL, name: nameL, phoneNumber: phoneNumberL, profileImage: profileImageL, docRef: docRefL)
        
        self.messagePersonBag.append(newPerson)
        print("Person Added")
    }
    
    public  func RemoveFromMessagePersonBag(personDict : [String:Any]){
          let idL = personDict["id"] as! String
        
      
       self.messagePersonBag.removeAll { (person) -> Bool in
            person.id == idL
        }
            
        }
    
    public  func HasInMessagePersonBag(personDict : [String:Any])->Bool{
           let idL = personDict["id"] as! String
        
   return    self.messagePersonBag.contains { (person) -> Bool in
            person.id == idL
        }
        
    }
      
    
}


class messagePerson {
    
 //Paramaterised Contructor
    internal init(id: String, name: String, phoneNumber: String, profileImage: String, docRef: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.profileImage = profileImage
        self.docRef = docRef
         self.hidden = false
     
    }
    
    //Default Constructor
    internal init() {
        self.id = ""
        self.name = ""
        self.phoneNumber = ""
        self.profileImage = ""
        self.docRef = ""
        self.hidden = false
  
    }
    
    //Data Members
    var id :String
    var name : String
    var phoneNumber :String
    var profileImage :String
    var docRef:String
    var hidden : Bool
  var  messagesRecievedDocRef = "AllMessages"
    
    
}


class Message : ObservableObject{
  
  
   var text = ""
   var time = ""
  var date = Date()
   var id = ""
   var isFromSelf : Bool = false//Boolean Value indicating whether message is sent by self or not
    //message issent by self if message is retrieved from Collection : "MessagesSent"-> Document:"AllMessages"

}

class MessageArray : ObservableObject{
  
   
    @Published var allMessages = [Message]()
 
  

}
