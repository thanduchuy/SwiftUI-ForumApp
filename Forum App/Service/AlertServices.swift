//
//  AlertServices.swift
//  Forum App
//
//  Created by MacBook Pro on 3/23/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

class AlertServices : ObservableObject {
    @Published var requests =  [UserInfo]()
    @Published var friend =  [UserInfo]()
    init() {
        dataFriend()
        getData()
    }
    func dataFriend() {
        if Auth.auth().currentUser != nil {
            Firestore.firestore().collection("User")
                .document((Auth.auth().currentUser?.uid)!).collection("Friends").addSnapshotListener { (snap, err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    }
                    snap!.documentChanges.forEach { diff in
                        if (diff.type == .added) {
                            let id = diff.document.documentID
                            let uid = diff.document.get("id") as! String
                            let name = diff.document.get("name") as! String
                            let email = diff.document.get("email") as! String
                            let avatar = diff.document.get("avatar") as! String
                            let idChat = diff.document.get("idChat") as! String
                            self.friend.append(UserInfo(id: id, avatar: avatar, email: email, name: name, uid: uid,idChat: idChat))
                        }
                        if diff.type == .modified {
                            self.friend = self.friend.map({ (info) -> UserInfo in
                                var data = info
                                if data.id == diff.document.documentID {
                                    data.uid = diff.document.get("id") as! String
                                    data.name = diff.document.get("name") as! String
                                    data.email = diff.document.get("email") as! String
                                    data.avatar = diff.document.get("avatar") as! String
                                    data.idChat = diff.document.get("idChat") as! String
                                    return data
                                } else {
                                    return info
                                }
                            })
                        }
                        if diff.type == .removed {
                            self.friend = self.friend.filter({ (UserInfo) -> Bool in
                                return !(UserInfo.id == diff.document.documentID)
                            })
                        }
                    }
            }
        }
    }
    func getData() {
        if Auth.auth().currentUser != nil {
            Firestore.firestore().collection("User")
                .document((Auth.auth().currentUser?.uid)!).collection("requestFriend").addSnapshotListener { (snap, err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    }
                    self.requests = [UserInfo]()
                    snap!.documentChanges.forEach { diff in
                        if (diff.type == .added) {
                            let id = diff.document.documentID
                            let uid = diff.document.get("id") as! String
                            let name = diff.document.get("name") as! String
                            let email = diff.document.get("email") as! String
                            let avatar = diff.document.get("avatar") as! String
                            
                            self.requests.append(UserInfo(id: id, avatar: avatar, email: email, name: name,uid:uid,idChat: ""))
                        }
                        if diff.type == .modified {
                            self.requests = self.requests.map({ (info) -> UserInfo in
                                var data = info
                                if data.id == diff.document.documentID {
                                    data.id = diff.document.get("id") as! String
                                    data.name = diff.document.get("name") as! String
                                    data.email = diff.document.get("email") as! String
                                    data.avatar = diff.document.get("avatar") as! String
                                    return data
                                } else {
                                    return info
                                }
                            })
                        }
                    }
            }
        }
    }
}
