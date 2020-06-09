//
//  PostCellBottom.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase


struct PostCellBottom : View {
    @State var id: String = ""
    @State var countLike : Int = 0
    @State var isFill : Bool = false
    @State var uidLikes =  [String]()
    @State var show = false
    @State var name = ""
    @State var uidPost : String = ""
    var uid = Auth.auth().currentUser?.uid
    func onClickBtnLike() {
        var msg = ""
        if uidLikes.contains(uid!) {
            isFill = false
            self.countLike -= 1
            self.uidLikes = self.uidLikes.filter(){$0 != uid!}
            msg = "don't liked your post !!"
        } else {
            isFill = true
            self.countLike += 1
            self.uidLikes.append(uid!)
            msg = "liked your post !!"
        }
        updateLikes(id: self.id, like: self.countLike)
        updateUidLikes(id: self.id, uidLikes: self.uidLikes)
        addAlertOfLike(uidPost: self.uidPost, noti: Noti(id: "", msg: msg, date: "", uid: "", name: self.name, isLike: true, isMakeFriend: false, isPost: false))
    }
    var body : some View {
        HStack(spacing: 40) {
            
            Button(action: onClickBtnLike) {
                HStack(spacing: 5) {
                    if isFill {
                        Image(systemName: "heart.fill").resizable().frame(width: 20, height: 20)
                    } else {
                        Image(systemName: "heart").resizable().frame(width: 20, height: 20)
                    }
                    Text("\(countLike)").font(.subheadline)
                }
            }.foregroundColor(.gray)
            
            Button(action: {
                print("b")
            }) {
                Image("repost").resizable().frame(width: 20, height: 20)
            }.foregroundColor(.gray)

            Button(action: {
                self.show.toggle()
            }) {
                HStack (spacing: 5){
                    Image("comment").resizable().frame(width: 20, height: 20)
                }
            }.foregroundColor(.gray)
            
            Button(action: {
                print("d")
            }) {
                Image(systemName: "icloud.and.arrow.up").resizable().frame(width: 20, height: 20)
            }.foregroundColor(.gray)
        }.sheet(isPresented: $show) {
            
            Chat(id:self.id,uid: self.uidPost,name: self.name).environmentObject(UserServices()).environmentObject(ChatServices())
        }
    }
}

struct PostCellBottom_Previews: PreviewProvider {
    static var previews: some View {
        PostCellBottom()
    }
}
