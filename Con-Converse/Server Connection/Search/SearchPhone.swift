//
//  SearchPhone.swift
//  Converse
//
//  Created by sachin jeph on 10/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import Foundation
import FirebaseFirestore

func searchPhoneOnDatabase(SearchPhoneNumber:String,Completion:@escaping (_ Result : [String :Any])->()){
    let db = Firestore.firestore()
    db.collection("Users").whereField("PhoneNumber", isEqualTo: SearchPhoneNumber).getDocuments { (snapshot, error) in
        if error != nil {
            print("Error in Performing the Seacrh")
            print(error!)
            return
        }
        //Documents Have Been Recieved
        if snapshot?.documents.count == 0 {print("User Does Not Exist");return }
        //User Found
        //snapshot?.documents.count should be == 1. Since 1 Phone Number will Have Only 1 user
        for document in snapshot!.documents{
            var result : [String:Any]  = [:]
            
            if let id = document.data()["id"] as? String{
                        result["id"] = id
                    }
            
            if let name = document.data()["Name"] as? String{
                result["name"] = name
            }
            
            if let phoneNumber = document.data()["PhoneNumber"] as? String{
                         result["phoneNumber"] = phoneNumber
                     }
            print("User Found")
            Completion(result)
         
            
        }
        
        
        
    }
    
}
//Done6
