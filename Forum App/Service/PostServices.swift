//
//  PostServices.swift
//  Forum App
//
//  Created by MacBook Pro on 3/18/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

func updateLikes(id:String,like:Int) {
     let db = Firestore.firestore()
        db.collection("Forums").document(id).updateData(["likes" : "\(like)"])
}

func updateUidLikes(id:String,uidLikes:[String]) {
     let db = Firestore.firestore()
        db.collection("Forums").document(id).updateData(["uidLikes" : uidLikes])
}

func addComments(msg: Msg,id:String) {
    Firestore.firestore().collection("Forums").document(id).collection("Comments").document().setData(["user":msg.user,"msg":msg.msg,"date":Date(),"uid":msg.uid,"avatar":msg.avatar])
}
func addMessage(msg:Msg,id:String) {
    Firestore.firestore().collection("Chats").document(id).collection("Message").document().setData(["user":msg.user,"msg":msg.msg,"date":Date(),"uid":msg.uid,"avatar":msg.avatar])
}
func removeChat(id:String) {
    Firestore.firestore().collection("Chats").document(id).collection("Message").getDocuments { (snap, err) in
        if err != nil {
            print((err?.localizedDescription)!)
            return
        }
        snap?.documents.forEach({ (item) in
            Firestore.firestore().collection("Chats").document(id).collection("Message").document(item.documentID).delete()
        })
    }
}
