//
//  AuthService.swift
//  Forum App
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import Firebase
import Combine

class AuthService : ObservableObject {
    
    var handle: AuthStateDidChangeListenerHandle?
    
    func SignUp(email: String,pass: String,handler: @escaping AuthDataResultCallback) {
        
        Auth.auth().createUser(withEmail: email, password: pass, completion: handler)
    }
    func SignIn(email: String,pass: String,handler: @escaping AuthDataResultCallback) {
        
        Auth.auth().signIn(withEmail: email, password:  pass, completion: handler)
    }
    func SignOut()  {
        
        do {
            try Auth.auth().signOut()
            print("Sign Out")
        } catch {
            print("error signin out")
        }
    }
    func addRequestFriend(user: UserInfo,uid: String) {
        
        Firestore.firestore().collection("User")
            .document(uid).collection("requestFriend")
            .document().setData(["id" : user.id, "name" : user.name, "email" : user.email, "avatar" : user.avatar]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                } else {
                    print("add request")
                }
        }
    }
    func submitRequest(user: UserInfo,uid:String,idChat:String) {
        Firestore.firestore().collection("User")
            .document(uid).collection("Friends")
            .document().setData(["id" : user.uid, "name" : user.name, "email" : user.email, "avatar" : user.avatar,"idChat":idChat]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                } else {
                    print("add friend")
                     self.addAlertFriend(uid: Auth.auth().currentUser!.uid, id: user.uid, name: user.name)
                }
        }
        
    }
    func addAlertFriend(uid:String,id:String,name:String) {
        Firestore.firestore().collection("User").document(uid).collection("Alert").document().setData(["name":name,"msg":"have become friends","date":Date(),"uid":id,"isLike":false,"isPost":false,"isMakeFriend":true])
    }
    func addFriend(user: UserInfo,uid:String,idChat:String) {
        Firestore.firestore().collection("User")
            .document(uid).collection("Friends")
            .document().setData(["id" : user.id, "name" : user.name, "email" : user.email, "avatar" : user.avatar,"idChat":idChat]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                } else {
                    print("add friend")
                    self.addAlertFriend(uid: uid, id: user.id, name: user.name)
                }
        }
    }
    func deleteRequest(id:String) {
        Firestore.firestore().collection("User")
            .document((Auth.auth().currentUser?.uid)!).collection("requestFriend")
            .document(id).delete()
    }
    func unfriends(id:String,uid:String) {
        Firestore.firestore().collection("User")
            .document(uid).collection("Friends")
            .document(id).delete()
    }
    func unfriendsTarget(uid:String) {
        Firestore.firestore().collection("User")
            .document(uid).collection("Friends").whereField("id", isEqualTo: (Auth.auth().currentUser?.uid)!).getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        Firestore.firestore().collection("User")
                            .document(uid).collection("Friends")
                            .document(document.documentID).delete()
                    }
                }
        }
    }
}
