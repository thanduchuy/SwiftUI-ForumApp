//
//  ChatServices.swift
//  Forum App
//
//  Created by MacBook Pro on 3/25/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase


class ChatServices : ObservableObject {
    @Published var comments = [Msg]()
    init() {
        
    }
    func getData(idPost:String) {
        Firestore.firestore().collection("Forums").document(idPost).collection("Comments").order(by: "date", descending: false).addSnapshotListener { (snap, err) in
            if err != nil {
                print((err?.localizedDescription)!)
                return
            }
            snap!.documentChanges.forEach { diff in
                if diff.type == .added {
                    let id = diff.document.documentID
                    let msg = diff.document.get("msg") as! String
                    let uid = diff.document.get("uid") as! String
                    let user = diff.document.get("user") as! String
                    let stamp = diff.document.get("date") as! Timestamp
                    let avatar = diff.document.get("avatar") as! String
                    
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd/MM/yy"
                    let date = formatter.string(from: stamp.dateValue())
                    
                    self.comments.append(Msg(id: id, msg: msg,uid:uid, user: user, date: date,avatar: avatar))
                }
                if diff.type == .modified {
                    self.comments = self.comments.map { (item) -> Msg in
                        var data = item
                        if data.id == diff.document.documentID {
                            data.msg = diff.document.get("msg") as! String
                            data.user = diff.document.get("user") as! String
                            data.uid = diff.document.get("uid") as! String
                            data.avatar = diff.document.get("avatar") as! String
                            let stamp = diff.document.get("date") as! Timestamp
                            let formatter = DateFormatter()
                            formatter.dateFormat = "dd/MM/yy"
                            let date = formatter.string(from: stamp.dateValue())
                            
                            data.date = date
                            return data
                        } else {
                            return item
                        }
                        
                    }
                }
            }
        }
    }
}

