//
//  Tabbar.swift
//  Forum App
//
//  Created by MacBook Pro on 3/16/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase

struct Tabbar: View {
    
    @State var show = false
    @Binding var status:Bool
    @EnvironmentObject var obg : AuthService
    var body: some View {
        ZStack {
            TabView {
                Search().tabItem {
                    
                    Image("search")
                    
                }.tag(1)
                
                Home().tabItem {
                    
                    Image("home")
                    
                }.tag(0)
                
                Notification().tabItem {
                    
                    Image("reminder")
                    
                }.tag(2)
                
                InfoView(status: $status).tabItem {
                    
                    Image("profile")
                    
                }.tag(3)
                
            }.accentColor(.blue)
                .edgesIgnoringSafeArea(.top)
            
            VStack{
                
                Spacer()
                
                HStack{
                    
                    Spacer()
                    
                    Button(action: {
                        
                        self.show.toggle()
                        
                    }) {
                        
                        Image("content").resizable().frame(width: 20, height: 20).padding()
                    }.foregroundColor(.accentColor).padding(2).background(Color.white)                       .clipShape(Circle())
                        .shadow(color: Color.black, radius: 8, x: 1, y: 1)
                    
                }.padding()
                
            }.padding(.bottom,65)
            
        }.sheet(isPresented: $show) {
            
            CreatePost(show: self.$show).environmentObject(AlertServices())
        }
    }
}

struct Tabbar_Previews: PreviewProvider {
    static var previews: some View {
        Tabbar(status: Binding.constant(true))
    }
}
