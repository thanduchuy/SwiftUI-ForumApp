//
//  InfoView.swift
//  Forum App
//
//  Created by MacBook Pro on 3/21/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase


struct InfoView: View {
    @EnvironmentObject var user : UserServices
    @EnvironmentObject var auth : AuthService
    @EnvironmentObject var observedData : getData
    @EnvironmentObject var alert : AlertServices
    @Binding var status : Bool
    @State var uidPost : String = ""
    @State private var buttonDisabled = false
    @State var txt  = "Send Friend Invitations"
    @State var isShow = false
    func signOut() {
        auth.SignOut()
        status = false
    }
    func checkUser(id:String) -> String {
        var result = ""
        self.alert.friend.forEach { (UserInfo) in
            if UserInfo.uid == id {
                result =  UserInfo.id
            }
        }
        return result
    }
    func onClickUnfriend()  {
        alert.friend.forEach { (item) in
            if item.uid == self.uidPost {
                removeChat(id: item.idChat)
            }
        }
        self.auth.unfriends(id: self.checkUser(id: self.user.info.id),uid:(Auth.auth().currentUser?.uid)!)
        self.auth.unfriendsTarget(uid:self.user.info.id)
    }
    var body: some View {
        VStack {
            if Auth.auth().currentUser != nil  {
                if uidPost == "" || uidPost == Auth.auth().currentUser!.uid {
                    if user.reset(uid:Auth.auth().currentUser!.uid) && user.isActive {
                        Image("Bg").resizable().frame(height:UIScreen.main.bounds.height/2).edgesIgnoringSafeArea(.top)
                        VStack {
                            AnimatedImage(url: URL(string: user.datas.avatar)!).resizable().frame(width: UIScreen.main.bounds.width, height: 240)
                            Text(user.datas.email).font(.title).foregroundColor(.black)
                            Text(user.datas.name).font(.subheadline).foregroundColor(Color.black.opacity(0.5)).padding(.bottom, 10)
                        }.frame(width: UIScreen.main.bounds.width).padding(.horizontal, -20).background(Color.white).cornerRadius(10).padding(.top, -290)
                        Spacer()
                        HStack {
                            VStack {
                                Text("\(self.observedData.totalPost)").bold().font(.system(size: 30)).padding(.bottom, 10)
                                Text("Posts").font(.system(size: 20))
                            }
                            Spacer()
                            VStack {
                                Text("\(self.observedData.totalLike)").bold().font(.system(size: 30)).padding(.bottom, 10)
                                Text("Like").font(.system(size: 20))
                            }
                        }.padding(.horizontal, 20)
                        Spacer()
                        if uidPost == "" {
                            Button(action: self.signOut) {
                                Text("Log Out")
                            }.frame(minWidth: 0, maxWidth: 300)
                                .padding()
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 40)
                                        .stroke(Color.white, lineWidth: 2)
                            ).padding(.bottom, 10)
                            
                            Button(action: {
                                self.isShow.toggle()
                            }) {
                                                     Text("Post On You")
                                                 }.frame(minWidth: 0, maxWidth: 300)
                                                     .padding()
                                                     .foregroundColor(.white)
                                                     .overlay(
                                                         RoundedRectangle(cornerRadius: 40)
                                                             .stroke(Color.white, lineWidth: 2)
                                                 )
                        }
                        Spacer()
                    }
                    
                }else {
                    if user.reset(uid:uidPost) && user.active {
                        Image("Bg").resizable().frame(height:UIScreen.main.bounds.height/2).edgesIgnoringSafeArea(.top)
                        VStack {
                            AnimatedImage(url: URL(string: user.info.avatar)!).resizable().frame(width: UIScreen.main.bounds.width, height: 240)
                            Text(user.info.email).font(.title).foregroundColor(.black)
                            Text(user.info.name).font(.subheadline).foregroundColor(Color.black.opacity(0.5)).padding(.bottom, 10)
                        }.frame(width: UIScreen.main.bounds.width).padding(.horizontal, -20).background(Color.white).cornerRadius(10).padding(.top, -250)
                        Spacer()
                        if checkUser(id: user.info.id) != "" {
                            Button(action:onClickUnfriend) {
                                Text("Unfriend").foregroundColor(.white).font(.headline)
                            }.frame(width: UIScreen.main.bounds.width-80).padding(15).background(Color.white.opacity(0.6)).cornerRadius(10)
                        } else {
                            Button(action: {
                                self.auth.addRequestFriend(user: self.user.datas, uid: self.uidPost)
                                self.txt = "You have sent a friend"
                                self.buttonDisabled.toggle()
                            }) {
                                Text(txt).foregroundColor(.black).font(.headline)
                            }.disabled(buttonDisabled)
                                .frame(width: UIScreen.main.bounds.width-80).padding(10).background(Color.white).cornerRadius(10)
                        }
                        Spacer()
                        
                    }
                }
            }
        }.sheet(isPresented: $isShow) {
            PostUser(data: self.$observedData.datas).environmentObject(UserServices())
        }
    }
}
