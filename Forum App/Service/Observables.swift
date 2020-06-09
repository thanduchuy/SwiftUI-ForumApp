//
//  Observables.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

let dbCollection = Firestore.firestore().collection("Forums")
class getData : ObservableObject{
    
    @Published var datas = [Post]()
    @Published var totalPost = 0
    @Published var totalLike = 0
    init() {
        getData()
    }
    func total(uid:String) -> Bool{
        self.totalLike = 0
        self.totalPost = 0
        datas.forEach { (Post) in
            if Post.uid == uid {
                self.totalPost += 1
                self.totalLike += Int(Post.likes)!
            }
        }
        return true
    }
    func getData() {
                dbCollection.addSnapshotListener { (snap, err) in
                    if err != nil {
                        print((err?.localizedDescription)!)
                        return
                    } else {
                        print("read data success")
                    }
                    snap!.documentChanges.forEach { diff in
                        if (diff.type == .added) {
                            let id = diff.document.documentID
                            let name = diff.document.get("name") as! String
                            let msg = diff.document.get("msg") as! String
                            let pic = diff.document.get("pic") as! String
                            let url = diff.document.get("url") as! String
                            let repost = diff.document.get("repost") as! String
                            let likes = diff.document.get("likes") as! String
                            let tagId = diff.document.get("id") as! String
                            let uid = diff.document.get("uid") as! String
                            let uidLikes = diff.document.get("uidLikes") as! [String]
                            if uid == Auth.auth().currentUser?.uid {
                                self.totalPost += 1
                                self.totalLike += Int(likes)!
                            }
                            self.datas.append(Post(uid:uid,id: id, name: name, msg: msg, likes: likes, pic: pic, url: url, repost:repost, tagId: tagId,uidLikes: uidLikes))
                        }
                        if (diff.type == .modified) {
                            self.totalPost = 0
                            self.totalLike = 0
                            self.datas = self.datas.map { (eachData) -> Post in
                                var data = eachData
                                if data.id == diff.document.documentID {
                                    data.name = diff.document.get("name") as! String
                                    data.msg = diff.document.get("msg") as! String
                                    data.pic = diff.document.get("pic") as! String
                                    data.url = diff.document.get("url") as! String
                                    data.repost = diff.document.get("repost") as! String
                                    data.likes = diff.document.get("likes") as! String
                                    data.tagId = diff.document.get("id") as! String
                                    data.uid = diff.document.get("uid") as! String
                                    data.uidLikes = diff.document.get("uidLikes") as! [String]

                                    return data
                                } else {
                                    return eachData
                                }
                            }
                            if Auth.auth().currentUser != nil {
                                self.total(uid:Auth.auth().currentUser!.uid)
                            }
                        }
                    }
                    
                }
            }
        }
        func addPost(msg : String,pic : String,name:String,email:String,avatar:String,uid: String,uidLikes : [String]){
            
            let db = Firestore.firestore()
            let id = db.collection("Forums").document().documentID
            dbCollection.document().setData(["idPost":id,"name" : email,"id":"@\(name.lowercased())","msg":msg,"repost":"0","likes":"0","pic":"\(pic)","url":"\(avatar)","uid":uid,"uidLikes":uidLikes,"Comments":[]]) { (err) in
                if err != nil {
                    print((err?.localizedDescription)!)
                    return
                }else {
                    print("create data success")
                }
    }

}
