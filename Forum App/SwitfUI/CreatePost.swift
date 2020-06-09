//
//  CreatePost.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth
struct CreatePost : View  {
    
    @Binding var show : Bool
    @State var txt = ""
    @State var picker = false
    @State var picData : Data = .init(count:0)
    @State var loading = false
    @EnvironmentObject var friend : AlertServices
    func getInfoUser() {
        let db = Firestore.firestore()
        let docRef = db.collection("User").document(Auth.auth().currentUser!.uid)
        docRef.getDocument { (document, error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            } else {
                let name = document?.get("name") as! String
                let email = document?.get("email") as! String
                let avatar = document?.get("avatar") as! String
                self.postImagePicker(name: name, email: email, avatar: avatar)
                self.addAlert(name:name)
            }
        }
    }
    func addAlert(name:String) {
        friend.friend.forEach { (UserInfo) in
            Firestore.firestore().collection("User").document(UserInfo.uid).collection("Alert").document().setData(["name":name,"msg":"Your friends added a new post","date":Date(),"uid":Auth.auth().currentUser!.uid,"isLike":false,"isPost":true,"isMakeFriend":false])
        }
    }
    var body : some View {
        VStack {
            HStack {
                Button(action: {
                    self.show.toggle()
                }) {
                    Text("Cancel")
                }
                Spacer()
                
                if loading {
                    indicator()
                } else {
                    Button(action: {
                        self.picker.toggle()
                    }) {
                        Image(systemName: "photo.fill").resizable().frame(width: 35, height: 25)
                    }.foregroundColor(Color("bg"))
                }
                
                Button(action: {
                    self.getInfoUser()
                }) {
                    Text("Post").padding()
                }.background(Color("bg"))
                    .foregroundColor(.white)
                    .clipShape(Capsule())
            }
            multilineTextFiel(txt: $txt)
        }.padding()
            .sheet(isPresented: $picker) {
                imagePicker(picked: self.$picker, picData: self.$picData)
        }
    }
    
    func postImagePicker(name:String,email:String,avatar:String){
        let storage = Storage.storage().reference()
        let id = Auth.auth().currentUser!.uid
        storage.child("pics").child(id).putData(self.picData, metadata: nil) { (data,error) in
            if error != nil {
                print((error?.localizedDescription)!)
                return
            }
            
            storage.child("pics").child(id).downloadURL { (url, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                if !self.loading && self.picData.count != 0 {
                    self.loading.toggle()
                    addPost(msg: self.txt,pic:"\(url!)",name: name,email:email,avatar: avatar,uid: id,uidLikes: [])
                }
                else if !self.loading {
                    addPost(msg: self.txt,pic:"",name:name,email:email,avatar:avatar,uid: id,uidLikes: [])
                }
                self.show.toggle()
            }
        }
    }
    
}


