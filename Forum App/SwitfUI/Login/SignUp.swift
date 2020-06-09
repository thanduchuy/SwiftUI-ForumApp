//
//  SignUp.swift
//  Forum App
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth
struct SignUp: View {
    @State var email: String = ""
    @State var name: String = ""
    @State var pass: String = ""
    @State var repass: String = ""
    @State var error: String = ""
    @State var link : String = "user"
    @State var picker = false
    @State var picData : Data = .init(count:0)
    @Binding var status: Bool
    @EnvironmentObject var session: AuthService
    func postImagePicker(name:String,email:String){
        let storage = Storage.storage().reference()
        let id = "\((Auth.auth().currentUser?.uid)!)"
        storage.child("avatar").child(id).putData(self.picData, metadata: nil) { (data,error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            storage.child("avatar").child(id).downloadURL { (url, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                self.addInfoUser(uid: Auth.auth().currentUser!.uid, name: name, email: email, avatar: "\(url!)")
            }
        }
    }
    func addInfoUser(uid:String,name : String,email : String,avatar : String) {
        let db = Firestore.firestore()
        
        db.collection("User").document(uid).setData(["name":name,"email":email,"avatar":avatar]) { (err) in
            if err != nil {
                self.error = err!.localizedDescription
            }
            self.status = true
        }
    }
    func signUp() {
        if pass != repass {
            self.error = "Retype password incorrect"
            return
        }
        session.SignUp(email: email, pass: pass) { (auth, err) in
            if err != nil {
                self.error = err!.localizedDescription
            } else {
                self.postImagePicker(name: self.name, email: self.email)
                self.resetForm()
            }
        }
    }
    func resetForm() {
        self.email = ""
        self.pass = ""
        self.repass = ""
        self.error = ""
        self.name = ""
        self.link = "user"
    }
    var body: some View {
        VStack(alignment: .center) {
            Spacer()
            Text("Welcome!").font(.largeTitle)
            Button(action: {
                self.picker.toggle()
                self.link = "check"
            }) {
                Image(link).resizable().frame(minWidth: 30, maxWidth: 100, minHeight:50 , maxHeight: 100).padding(5).background(Color.white).clipShape(Circle())
            }.foregroundColor(.black)
            VStack {
                TextField("Enter Email ...", text: $email)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(UIScreen.main.bounds.height/2).padding(.bottom, 5)
                
                TextField("Enter Name ...", text: $name)
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(UIScreen.main.bounds.height/2).padding(.bottom, 5)
                
                SecureField("Enter Password...", text: $pass)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(UIScreen.main.bounds.height/2).padding(.bottom, 5)
                SecureField("Enter RePassword...", text: $repass)
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.white.opacity(0.4))
                    .cornerRadius(UIScreen.main.bounds.height/2).padding(.bottom, 5)
            }
            Text(self.error).bold()
            Button(action: signUp) {
                HStack {
                    Text("SIGN UP")
                        .font(.system(size: 15)).bold()
                }
                .frame(minWidth: 0, maxWidth: 300)
                .padding()
                .foregroundColor(.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(Color.white, lineWidth: 2)
                )
                
            }
            Spacer()
            HStack {
                Text("Already have an account?").font(.system(size: 15)).foregroundColor(.white)
                Button(action: {
                    print("Sign IN ....")
                }) {
                    Text("SIGN IN").font(.system(size: 15)).bold().foregroundColor(.white)
                }
            }
        }.padding()
            .sheet(isPresented: $picker) {
                imagePicker(picked: self.$picker, picData: self.$picData)
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp(status: Binding.constant(true)).environmentObject(AuthService())
    }
}
