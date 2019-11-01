//
//  SignUp.swift
//  
//
//  Created by sachin jeph on 31/07/19.
//

import SwiftUI

struct UserSignUpScreen: View {
       @EnvironmentObject var CurrentUser : UserBindableObject
    @State var phoneNumber = ""
    @State var askForCode = false
    @State var enteredPhoneNumber = ""
    @State var profileName = ""
     @State var profileNameLabel =  "Please enter Profile Name"
   // @Binding var loggedIn : Bool?
    var body: some View {
   // NavigationView{
        VStack{
        
            HStack{  Text("Converse")
            .fontWeight(.black)
                       .lineLimit(nil)
                       .font(.largeTitle)
           Spacer()
            }.padding()
        
          //  Divider().padding(.horizontal)
            
        Text("Please enter your Phone Number to Login or Register")
            .fontWeight(.heavy)
            .lineLimit(nil)
            .font(.title)
            .foregroundColor(.primary)
            .padding()
           // .background(Color.pink)
            .cornerRadius(20)
            .padding()
        
            if askForCode {
                HStack{
         Text(UserDefaults.standard.string(forKey: "UserPhoneNumber")!)
                    .fontWeight(.bold)
                    .lineLimit(nil)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(20)
                   .padding(.vertical)
                    
                    Image(systemName: "checkmark.circle.fill")
                    .resizable()
                        .frame(width:50,height: 50)
                    .foregroundColor(.green)
                   // .background(Color.primary)
                
            }
        }
      HStack   {
     // Spacer()
            TextField(askForCode ? "Verification Code":"Phone Number", text: $phoneNumber){
                UIApplication.shared.keyWindow?.endEditing(true)}
          .frame(height:60)
                .font(.title)
        
         //  Spacer()
        
            }
        if self.phoneNumber.count > 0 {
            Button(action:withAnimation{{self.callSignUp()}}){
                Text(askForCode ? "Done" : "Next")
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
            Text(profileNameLabel)
                       .fontWeight(.heavy)
                       .lineLimit(nil)
                       .font(.title)
                       .foregroundColor(.primary)
                       .padding()
                      // .background(Color.pink)
                       .cornerRadius(20)
                       .padding()
                     HStack   {
                      //  Spacer()
            TextField( "Your Name", text: $profileName)
            {
            UIApplication.shared.keyWindow?.endEditing(true)}
                .frame(height:60)
                         .font(.title)
                    //    Spacer()
            }
            
            Spacer()
      //  }.navigationBarTitle(Text("Converse"))
        }.background(Image("LoginBG").resizable().scaledToFill().offset(y:-10))
            .edgesIgnoringSafeArea(.all)
    }
  
    
    func callSignUp(){
       if askForCode  {
         //When Verification code is given
        if(profileName == "")||(profileName == " "){profileNameLabel = "Please enter Profile Name ⚠️";return}
        
        userSignUpFinal(name:profileName,verificationCode: self.phoneNumber, Completion: { isLoggedIn,userID  in
             UIApplication.shared.keyWindow?.endEditing(true)
           //Setting data for CurrentUser
            self.CurrentUser.isLoggedIn = isLoggedIn
           if(self.CurrentUser.isLoggedIn)
                {
                    self.CurrentUser.phoneNumber =  UserDefaults.standard.string(forKey: "UserPhoneNumber")!
                    print("phone number is ",self.CurrentUser.phoneNumber)
                    print("UUID IS ",userID)
                    self.CurrentUser.id = userID
                    UserDefaults.standard.set(userID, forKey: "userID")
                    
           }
            else{
            self.askForCode = false
                   self.phoneNumber = ""
            
            }
            
            })}else {
        //When Number is given
      
        userSignUpInitial(phoneNumber: self.phoneNumber) {
            //It is a completin handler and is called when the above function has fully completed it task upto the point
            // where Completion handler is called
            self.askForCode = true
        self.phoneNumber = ""

        
            }
        
        }
       
        
        
      
    }
}

//StartedNow
