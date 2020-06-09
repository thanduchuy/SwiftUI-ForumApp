//
//  ChatItem.swift
//  Forum App
//
//  Created by MacBook Pro on 3/21/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
struct ChatItem: View {
    @State var name : String = ""
    @State var msg : String = ""
    @State var id : String = ""
    @State var avatar : String = ""
    var body: some View {
        HStack {
            if id == Auth.auth().currentUser?.uid {
                Spacer()
                Text(msg)
                    .padding()
                    .background(Color.blue)
                    .clipShape(ChatBubble(mymsg: true))
                    .foregroundColor(.white)
                if avatar != "" {
                    AnimatedImage(url: URL(string: avatar)!).resizable().frame(width: 30, height: 30).clipShape(Circle())
                }
            } else {
                if avatar != "" {
                    AnimatedImage(url: URL(string: avatar)!).resizable().frame(width: 30, height: 30).clipShape(Circle())
                }
                VStack (alignment: .leading){
                    Text(msg)
                        .padding()
                        .background(Color.green)
                        .clipShape(ChatBubble(mymsg: false))
                        .foregroundColor(.white)
                    Text(name).font(.system(size: 10))
                }
                Spacer()
            }
        }.padding(.horizontal, 10)
    }
}

struct ChatItem_Previews: PreviewProvider {
    static var previews: some View {
        ChatItem()
    }
}
