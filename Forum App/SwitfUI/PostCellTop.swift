//
//  PostCellTop.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct PostCellTop : View {
    
    var name = ""
    var id = ""
    var pic = ""
    var image = ""
    var msg = ""
    @State var isShow : Bool = false
    @State var uid : String = ""
    
    var body : some View {
        HStack (alignment: .top){
            VStack {
                Button(action: {
                    self.isShow = true
                }) {
                    AnimatedImage(url: URL(string: image)!).resizable().frame(width: 50, height: 50).clipShape(Circle())
                }
            }
            VStack(alignment: .leading) {
                Text(name).fontWeight(.heavy)
                Text(id)
                Text(msg).padding(.top, 8)
            }
        }.padding()
            .sheet(isPresented: $isShow) {
                InfoView(status: Binding.constant(false),uidPost: self.uid).environmentObject(UserServices()).environmentObject(getData()).environmentObject(AuthService()).environmentObject(AlertServices())
        }
    }
}

