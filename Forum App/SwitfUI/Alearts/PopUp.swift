//
//  PopUp.swift
//  Forum App
//
//  Created by MacBook Pro on 3/25/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI

struct PopUp: View {
    @EnvironmentObject var data : AlertServices
    var body: some View {
        NavigationView {
            ZStack {
                Color.white.opacity(0.5).edgesIgnoringSafeArea(.all)
                ScrollView(.vertical,showsIndicators: false) {
                    VStack {
                        if data.friend.count == 0 {
                            VStack {
                                Spacer()
                                Text("You have no friends").fontWeight(.semibold).foregroundColor(.black)
                                Spacer()
                            }.padding()
                        } else {
                            ForEach(data.friend) { item in
                                ZStack (alignment: .trailing){
                                    HStack {
                                        AnimatedImage(url: URL(string: item.avatar)!).resizable().frame(width: 50, height: 50).clipShape(Circle())
                                        VStack(alignment: .leading) {
                                            Text(item.email).fontWeight(.semibold).foregroundColor(.black)
                                            Text(item.name).font(.caption).padding(.top, 8).foregroundColor(.black)
                                            Divider()
                                        }
                                    }
                                    NavigationLink(destination: ChatBox(idChat:item.idChat)) {
                                        Image(systemName: "arrow.right").foregroundColor(.gray)
                                    }
                                }
                            }
                        }
                    }.padding()
                }.background(Color.white)
                    .frame(width: UIScreen.main.bounds.width - 80 , height: UIScreen.main.bounds.height - 280)
                    .cornerRadius(8)
                    .padding(.top, 20)
            }.onAppear {
                self.data.friend = [UserInfo]()
                self.data.dataFriend()
            }
        }
    }
}

