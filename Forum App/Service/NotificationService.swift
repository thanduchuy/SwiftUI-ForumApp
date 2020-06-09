//
//  NotificationService.swift
//  Forum App
//
//  Created by MacBook Pro on 3/28/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

class NotificationService: ObservableObject {
    @Published var data = [Noti]()
    init() {
       getData()
    }
    func getData() {
        if Auth.auth().currentUser != nil {
            Firestore.firestore().collection("User").document((Auth.auth().currentUser?.uid)!).collection("Alert").order(by: "date", descending: false).limit(to: 3).addSnapshotListener { (snap, err) in
                       if err != nil {
                           print((err?.localizedDescription)!)
                           return
                       }
                       snap?.documentChanges.forEach({ (querry) in
                           if querry.type == .added  {
                               let id = querry.document.documentID
                               let name = querry.document.get("name") as! String
                               let msg = querry.document.get("msg") as! String
                               let stamp = querry.document.get("date") as! Timestamp
                               let uid = querry.document.get("uid") as! String
                               let isLike = querry.document.get("isLike") as! Bool
                               let isMakeFriend = querry.document.get("isMakeFriend") as! Bool
                               let isPost = querry.document.get("isPost") as! Bool
                               let formatter = DateFormatter()
                               formatter.dateFormat = "dd/MM/yy"
                               let date = formatter.string(from: stamp.dateValue())
                               
                                if uid != Auth.auth().currentUser?.uid {
                                    self.data.append(Noti(id: id, msg: msg, date: date, uid: uid, name: name,isLike: isLike,isMakeFriend: isMakeFriend,isPost: isPost))
                                }
                           }
                           if querry.type == .modified {
                               self.data = self.data.map { (temp) -> Noti in
                                   if temp.id == querry.document.documentID {
                                       var result = temp
                                       result.name = querry.document.get("name") as! String
                                       result.msg = querry.document.get("msg") as! String
                                       let stamp = querry.document.get("date") as! Timestamp
                                       result.uid = querry.document.get("uid") as! String
                                       result.isLike = querry.document.get("isLike") as! Bool
                                       result.isMakeFriend = querry.document.get("isMakeFriend") as! Bool
                                       result.isPost = querry.document.get("isPost") as! Bool
                                       let formatter = DateFormatter()
                                       formatter.dateFormat = "dd/MM/yy"
                                       let date = formatter.string(from: stamp.dateValue())
                                       result.date = date
                                       return temp
                                   } else {
                                       return temp
                                   }
                               }
                           }
                       })
                   }
        }
    }
}

func addAlertOfLike(uidPost:String,noti:Noti) {
    Firestore.firestore().collection("User").document(uidPost).collection("Alert").document().setData(["name":noti.name,"msg":noti.msg,"date":Date(),"uid":Auth.auth().currentUser!.uid,"isLike":noti.isLike,"isPost":noti.isPost,"isMakeFriend":noti.isMakeFriend])
}


