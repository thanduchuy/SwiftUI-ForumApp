//
//  Request.swift
//  Forum App
//
//  Created by MacBook Pro on 3/23/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
struct Request: View {
    @EnvironmentObject var alert : AlertServices
    @EnvironmentObject var auth : AuthService
    @EnvironmentObject var user : UserServices
    @State var idChat : String = ""
    func randomString(length: Int) -> Bool {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        idChat =  String((0..<length).map{ _ in letters.randomElement()! })
        return true
    }
    func removeRequest(users: [UserInfo],id:String) -> [UserInfo]{
        var user = users
        user = user.filter { (UserInfo) -> Bool in
            return !(UserInfo.id == id)
        }
        return user
    }
    var body: some View {
        VStack {
                if alert.requests.count == 0 {
                    Spacer()
                    Text("You have no friend requests").font(.title)
                    Spacer()
                } else {
                    ScrollView {
                        VStack(spacing: 15){
                            ForEach(alert.requests) { item in
                                VStack {
                                    AnimatedImage(url: URL(string: item.avatar)!).resizable().frame( height: 250)
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(item.email).font(.body).fontWeight(.heavy)
                                            Text(item.name).font(.subheadline).fontWeight(.heavy)
                                        }
                                        Spacer()
                                        Button(action: {
                                            if self.randomString(length: 20) {
                                                    self.auth.submitRequest(user: item,uid: (Auth.auth().currentUser?.uid)!,idChat: self.idChat)
                                                    self.auth.deleteRequest( id: item.id)
                                                    self.auth.addFriend(user: self.user.datas,uid: item.uid,idChat: self.idChat)
                                                    self.alert.requests = self.removeRequest(users: self.alert.requests, id: item.id)
                                            }
                                        }) {
                                            Image(systemName: "hand.thumbsup.fill").font(.body).foregroundColor(.black).padding(10)
                                        }.background(Color.white)
                                            .clipShape(Circle())
                                        Button(action: {
                                            self.alert.requests = self.removeRequest(users: self.alert.requests, id: item.id)
                                            self.auth.deleteRequest( id: item.id)
                                        }) {
                                            Image(systemName: "hand.thumbsdown.fill").font(.body).foregroundColor(.black).padding(10)
                                        }.background(Color.white)
                                            .clipShape(Circle())
                                    }.padding(.horizontal)
                                        .padding(.bottom,6)
                                }
                                .padding(.horizontal, 10)
                                .cornerRadius(40)
                            }
                        }
                    }
                }
        }.onAppear {
            self.alert.getData()
        }
    }
}

struct Request_Previews: PreviewProvider {
    static var previews: some View {
        Request()
    }
}
