//
//  ChatUserServices.swift
//  Forum App
//
//  Created by MacBook Pro on 3/27/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
class ChatUserServices : ObservableObject {
    @Published var data =  [Msg]()
    init() {
        
    }
    func getMSG(id:String) {
        Firestore.firestore().collection("Chats").document(id).collection("Message").order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            snap?.documentChanges.forEach({ (doc) in
                if doc.type == .added {
                    let id = doc.document.documentID
                    let msg = doc.document.get("msg") as! String
                    let uid = doc.document.get("uid") as! String
                    let user = doc.document.get("user") as! String
                    let stamp = doc.document.get("date") as! Timestamp
                    let avatar = doc.document.get("avatar") as! String
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yy"
                    let date = formatter.string(from: stamp.dateValue())
                    
                    self.data.append(Msg(id: id, msg: msg,uid:uid, user: user, date: date,avatar: avatar))
                }
                if doc.type == .modified {
                    self.data = self.data.map({ (Msg) -> Msg in
                        var result = Msg
                        if result.id == doc.document.documentID {
                            result.msg = doc.document.get("msg") as! String
                            result.uid = doc.document.get("uid") as! String
                            result.user = doc.document.get("user") as! String
                            let stamp = doc.document.get("date") as! Timestamp
                            result.avatar = doc.document.get("avatar") as! String
                            
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd/MM/yy"
                            result.date = formatter.string(from: stamp.dateValue())
                            return result
                        } else {
                            return Msg
                        }
                    })
                }
            })
        }
    }
}
