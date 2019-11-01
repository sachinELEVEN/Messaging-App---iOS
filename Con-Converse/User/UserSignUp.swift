//
//  UserSignUp.swift
//  Converse
//
//  Created by sachin jeph on 31/07/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


func userSignUpInitial(phoneNumber:String, Completion: @escaping ()->()){
 
    
    //This helps in verifying if the user's app has sent a request for phone verification
    PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { (verificationID, error) in
        if error != nil {
             print("Recieved Error")
            print(error ?? "Error_01 ")
            return
        }
        //verificationID recieved
        //verificationID is sent by firebase to the app not the user.
        print("Recieved ID")
      UserDefaults.standard.set(phoneNumber, forKey: "UserPhoneNumber")
      UserDefaults.standard.set(verificationID, forKey: "verificationID")
        Completion()
   
        
    }
   
   
    
}

func userSignUpFinal(name:String,verificationCode:String, Completion: @escaping (_ isLogged:Bool,_ id:String)->()){
    
    guard let verID = UserDefaults.standard.string(forKey: "verificationID") else{print("No verID");return}
    print("VerID",verID)
     let credential = PhoneAuthProvider.provider().credential(
    withVerificationID: verID,
    verificationCode: verificationCode)

    Auth.auth().signIn(with: credential) { (autoResult, error) in
        if(error != nil){
            print("Error_02",error!)
            UserDefaults.standard.set(false, forKey: "isUserLoggedIn")
            UserDefaults.standard.removeObject(forKey: "UserPhoneNumber")
            Completion(false,"nil")
            return}
        //User is signed up
        print("User is Signed up")
        UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
       // UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
        //
        let userUID = autoResult?.user.uid
        let db = Firestore.firestore()
        let userDocRef =    db.collection("Users").document(userUID!)
   //userDocRef is the name of the document in the users collection
        //userDocRef and userUID is same
        
        let userPersonalData = ["Name":name,"PhoneNumber":  UserDefaults.standard.string(forKey: "UserPhoneNumber")!,"id":userUID!] as [String : Any]
        userDocRef.setData(userPersonalData) { (error) in//Creates Document if not already exists
            if error != nil {
                print("Error_3. User Created but unable give User a Space")
                return
            }
            //Creating A document where all messages sent to a user will be stored 
          
         //   db.collection("Users").document(userUID!).collection("MessagesRecieved").document("AllMessages")
           let docID = UUID().uuidString
                      let newData : [String:Any] = ["id":docID]
                      db.collection("Users").document(userUID!).collection("MessagesRecieved").document("AllMessages").setData(newData)
            
            let docID2 = UUID().uuidString
                                 let newData2 : [String:Any] = ["id":docID2]
                                 db.collection("Users").document(userUID!).collection("MessagesSent").document("AllMessages").setData(newData2)
            
            
            
            //User Has been alloted a Space in the Database
           
            print("UUID IS ",userUID!)
            Completion(true,userUID!)
            userLoggedIn = true
     //       db.collection("Users").document("d").collection("d").document().collection("d").
            
        }
    }

}
//to check if user is currently logged in use isUserLoggedIn if true than access its phone number
//Done8
