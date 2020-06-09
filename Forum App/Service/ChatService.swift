//
//  ChatService.swift
//  Forum App
//
//  Created by MacBook Pro on 3/20/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

let db = Firestore.firestore().collection("Posts")
class ChatService : ObservableObject{
    @Published var datas = [Msg]()
    init(id:String) {
        db.document(id).collection("comments").addSnapshotListener { (snap, err) in
                       if err != nil {
                           print((err?.localizedDescription)!)
                           return
                       }
                       snap!.documentChanges.forEach { diff in
                           if (diff.type == .added) {
                               let id = diff.document.documentID
                               let user = diff.document.get("user") as! String
                               let msg = diff.document.get("msg") as! String
                               let stamp = diff.document.get("date") as! Timestamp
                               
                               let formatter = DateFormatter()
                               formatter.dateFormat = "dd/MM/yy"
                               let date = formatter.string(from: stamp.dateValue())
                               
                               self.datas.append(Msg(id: id, msg: msg, user: user, date: date))
                           }
                           if (diff.type == .modified) {
                               self.datas = self.datas.map { (eachData) -> Msg in
                                   var data = eachData
                                   if data.id == diff.document.documentID {
                                       data.user = diff.document.get("user") as! String
                                       data.msg = diff.document.get("msg") as! String
                                       let stamp = diff.document.get("date") as! Timestamp
                                       let formatter = DateFormatter()
                                       formatter.dateFormat = "dd/MM/yy"
                                       
                                       data.date = formatter.string(from: stamp.dateValue())
                                       return data
                                   }else {
                                       return eachData
                                   }
                               }
                           }

                   }
               }
    }

}
