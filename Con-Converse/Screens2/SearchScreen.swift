//
//  SearchScreen.swift
//  Converse
//
//  Created by sachin jeph on 10/08/19.
//  Copyright © 2019 sachin jeph. All rights reserved.
//

import SwiftUI
import FirebaseFirestore

struct SearchScreen: View {
         @EnvironmentObject var CurrentUser : UserBindableObject
    @State var PhoneNumberToBeSearched = ""
    @State var  queryResult = [String:Any]()
    @State var showQueryResult = false
    var body: some View {
    
     //   ScrollView(.vertical,showsIndicators: false){
            VStack{

            TextField("Phone Number", text: $PhoneNumberToBeSearched){
                UIApplication.shared.keyWindow?.endEditing(true)
            }.frame(height:60)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.title)
                .padding(.horizontal)
  
            if(true){
                    if(!showQueryResult){
                                  Spacer()
                                  }
                Button(action:withAnimation{{searchPhoneOnDatabase(SearchPhoneNumber: self.PhoneNumberToBeSearched) { (searchUser) in
              
                    let userKnown = self.CurrentUser.messagePersonBag.contains { (person) -> Bool in
                        person.id == searchUser["id"] as! String
                                       }
                    
                      self.queryResult = searchUser
                    self.queryResult["personKnown"] = userKnown
                    
                self.showQueryResult = true
            }}}){
                            Text("Search")
                                        .fontWeight(.bold)
                                      .foregroundColor(.white)
                                   
                                .frame(width:250)
                                .padding([.horizontal,.vertical])
                                     .background(Color.blue)
                                     .cornerRadius(10)
                        }
                 if(!showQueryResult){
                Spacer()
                 }
                }
            
          //  Spacer()
            //Search Result
         if(showQueryResult){
            QueryResult(queryResult:self.queryResult)
            }
            
       
                
        }.navigationBarTitle(Text("Search by Phone"))
 //   }
    }
}



struct   QueryResult :View{
       @EnvironmentObject var CurrentUser : UserBindableObject
    var   queryResult = [String :Any]()
    var body : some View{
      
        VStack(alignment:.leading){
            
                 Divider()
            
        Text("Search Results")
            .fontWeight(.heavy)
            .font(.title)
        
        //List{Section{
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
                    Text(queryResult["name"] as! String)
                                   .fontWeight(.bold)
                               
                               Text(queryResult["phoneNumber"] as! String)
                                             .fontWeight(.semibold)
            
                      }
                Spacer()
                if(!(self.CurrentUser.HasInMessagePersonBag(personDict: self.queryResult))){
                Button(action:{self.CurrentUser.AddToMessagePersonBag(personDict: self.queryResult)}){
                        Image(systemName: "plus")
                    .resizable()
                        .frame(width:30,height:30)
                }
               }else{
                Button(action:{self.CurrentUser.RemoveFromMessagePersonBag(personDict: self.queryResult)}){
                                     Image(systemName: "checkmark")
                                 .resizable()
                                     .frame(width:30,height:30)
                             }
                }
                
            }
            .padding()
            .background(Color.secondary.opacity(0.2))
            .cornerRadius(20)
            
    //        }
     //   }.listStyle(.grouped)
        Spacer()
        }.padding()
            
      
        
    }
}
//Done1
