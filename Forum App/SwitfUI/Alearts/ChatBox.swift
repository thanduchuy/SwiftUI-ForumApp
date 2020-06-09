//
//  ChatBox.swift
//  Forum App
//
//  Created by MacBook Pro on 3/26/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

import Firebase

struct ChatBox: View {
    @State var idChat = ""
    @EnvironmentObject var chat : ChatUserServices
    var body: some View {
        ZStack {
            Color.white.opacity(0.5).edgesIgnoringSafeArea(.all)
            VStack {
                if chat.data.count == 0 {
                    Spacer()
                    Image("conversation")
                    Spacer()
                } else {
                    ScrollView {
                        ForEach(chat.data) { item in
                            HStack {
                                ChatItem(name:item.user, msg: item.msg, id:item.uid,avatar:item.avatar)
                            }.padding(.top,5)
                        }
                    }
                }
                ChatBoxBottom(idChat:idChat)
            }.padding(.top, -50)
        }.onAppear {
            self.chat.data = [Msg]()
            self.chat.getMSG(id: self.idChat)
        }
    }
}
