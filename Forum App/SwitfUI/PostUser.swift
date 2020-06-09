//
//  PostUser.swift
//  Forum App
//
//  Created by MacBook Pro on 3/30/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
struct PostUser: View {
    @Binding var data : [Post]
    @EnvironmentObject var user : UserServices
    private let uid = Auth.auth().currentUser?.uid
    var body: some View {
        VStack {
            if self.data.filter({$0.uid.contains(uid!)}).count == 0 {
                Text("No post...").fontWeight(.regular).foregroundColor(.black).padding()
            }
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(self.data.filter{$0.uid.contains(uid!)}) { i in
                        PostCellTop(name: i.name, id: i.tagId, pic: i.pic, image: i.url, msg: i.msg,uid: i.uid)
                        
                        if i.pic != ""{
                            
                            PostCellMidle(pic: i.pic).padding(.leading, 60)
                            
                        }
                        PostCellBottom(id: i.id, countLike: Int(i.likes)!,isFill: i.uidLikes.contains(self.uid!),uidLikes: i.uidLikes ,name: self.user.datas.name,uidPost:i.uid ).offset(x: UIScreen.main.bounds.width / 4)
                    }
                }.foregroundColor(.white)
            }
        }
    }
}

