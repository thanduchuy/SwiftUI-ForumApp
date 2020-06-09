//
//  UserServices.swift
//  Forum App
//
//  Created by MacBook Pro on 3/20/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//
import SwiftUI
import Firebase

let dbUser = Firestore.firestore().collection("User")
class UserServices : ObservableObject {
    @Published var datas = UserInfo(id: "", avatar: "", email: "", name: "",uid: "", idChat: "")
    @Published var info = UserInfo(id: "", avatar: "", email: "", name: "",uid: "",idChat: "")
    @Published var isActive = false
    @Published var active = false
    init() {
        if Auth.auth().currentUser != nil {
            Firestore.firestore().collection("User").document(Auth.auth().currentUser!.uid).getDocument { (snap, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                } else {
                    let id = snap?.documentID
                    let avatar = snap?.get("avatar") as! String
                    let email = snap?.get("email") as! String
                    let name = snap?.get("name") as! String
                    
                    self.datas.id = id!
                    self.datas.name = name
                    self.datas.avatar = avatar
                    self.datas.email = email
                    self.isActive = true
                }
                
            }
        }
    }
    func reload() {
        if Auth.auth().currentUser != nil {
                  Firestore.firestore().collection("User").document(Auth.auth().currentUser!.uid).getDocument { (snap, error) in
                      if error != nil {
                          print((error?.localizedDescription)!)
                          return
                      } else {
                          let id = snap?.documentID
                          let avatar = snap?.get("avatar") as! String
                          let email = snap?.get("email") as! String
                          let name = snap?.get("name") as! String
                          
                          self.datas.id = id!
                          self.datas.name = name
                          self.datas.avatar = avatar
                          self.datas.email = email
                          self.isActive = true
                      }
                      
                  }
              }
    }
    func reset(uid:String) -> Bool {
        if Auth.auth().currentUser != nil  {
            Firestore.firestore().collection("User").document(uid).getDocument { (snap, error) in
                if error != nil {
                    print((error?.localizedDescription)!)
                    return
                }
                let id = snap?.documentID
                let avatar = snap?.get("avatar") as! String
                let email = snap?.get("email") as! String
                let name = snap?.get("name") as! String
                
                if uid == Auth.auth().currentUser?.uid {
                    self.datas.id = id!
                    self.datas.name = name
                    self.datas.avatar = avatar
                    self.datas.email = email
                } else {
                    self.info.id = id!
                    self.info.name = name
                    self.info.avatar = avatar
                    self.info.email = email
                }
                self.active = true
            }
        }
        return true
    }
    
}
