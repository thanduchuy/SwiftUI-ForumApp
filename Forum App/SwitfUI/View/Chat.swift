//
//  Chat.swift
//  Forum App
//
//  Created by MacBook Pro on 3/19/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

struct Chat: View {
    @State var txt : String = ""
    @State var id : String = ""
    @State var uid : String = ""
     @State var name : String = ""
    @EnvironmentObject var user : UserServices
    @EnvironmentObject var chat : ChatServices
    
    func addComment() {
        let msg = self.txt
        let user = self.user.datas.name
        addComments(msg: Msg(id: "", msg: msg,uid: (Auth.auth().currentUser?.uid)!, user: user, date: "",avatar: self.user.datas.avatar), id: self.id)
        addAlertOfLike(uidPost: uid, noti: Noti(id: "", msg: "Commented on your post", date: "", uid: uid, name: name, isLike: true, isMakeFriend: false, isPost: false))
        txt = ""
    }
    var body: some View{
        VStack {
            if user.reset(uid: (Auth.auth().currentUser?.uid)!) {
                    if chat.comments.count == 0 {
                        Spacer()
                        Image("group")
                        Spacer()
                    } else {
                        ScrollView {
                            VStack(spacing: 5) {
                                ForEach(self.chat.comments) { item in
                                    ChatItem(name:item.user, msg: item.msg, id:item.uid)
                                }
                            }
                        }.padding(.top, 10)
                    }
                }
                HStack {
                    TextField("Enter Comment...", text: $txt).padding(2).textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    Button(action: addComment) {
                        Text("Send").background(Color("bg")).foregroundColor(.white).cornerRadius(2)
                    }
                }
        }.onAppear {
            self.chat.comments = [Msg]()
            self.chat.getData(idPost: self.id) 
        }
    }
}

struct Chat_Previews: PreviewProvider {
    static var previews: some View {
        Chat()
    }
}
