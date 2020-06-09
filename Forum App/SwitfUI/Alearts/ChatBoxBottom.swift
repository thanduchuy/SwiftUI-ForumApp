//
//  ChatBoxBottom.swift
//  Forum App
//
//  Created by MacBook Pro on 3/26/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

struct ChatBoxBottom: View {
    @State var idChat : String = ""
    @State var txt : String = ""
        @EnvironmentObject var user : UserServices
    func addMess() {
          let msg = self.txt
          let user = self.user.datas.name
          addMessage(msg: Msg(id: "", msg: msg,uid: (Auth.auth().currentUser?.uid)!, user: user, date: "",avatar: self.user.datas.avatar), id: self.idChat)
          txt = ""
      }
    var body: some View {
        HStack{
            
            HStack(spacing : 8){
                
                TextField("Type Something", text: $txt).foregroundColor(.black)
                
                Button(action: {
                    
                }) {
                    
                    Image(systemName: "trash").font(.body)
                    
                }.foregroundColor(.gray)
                
            }.padding()
                .background(Color("Color"))
                .clipShape(Capsule())
            
            Button(action: addMess) {
                
                Image(systemName: "paperplane.fill")
                    .resizable()
                    .frame(width: 15, height: 23)
                    .padding(13)
                    .foregroundColor(.white)
                    .background(Color("bg"))
                    .clipShape(Circle())
                
            }.foregroundColor(.gray)
            
        }.padding(.horizontal, 15)
    }
}

