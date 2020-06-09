//
//  Notification.swift
//  Forum App
//
//  Created by MacBook Pro on 3/22/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Notification: View {
    
    @State var selected = 0
    @State var show = false
    var body: some View {
        ZStack {
            VStack {
                TopBar(selected: $selected,show:$show)
                
                GeometryReader {_ in
                    VStack {
                        if self.selected == 0 {
                            Alert()
                        } else if self.selected == 1 {
                            Request()
                        }
                    }
                }
            }
            if self.show {
                GeometryReader { _ in
                    VStack {
                        PopUp()
                        
                        Button(action: {
                            withAnimation {
                                self.show.toggle()
                            }
                        }) {
                            Image(systemName: "xmark").resizable().frame(width: 15, height: 15).foregroundColor(.black).padding(20)
                        }.background(Color.white)
                            .clipShape(Circle())
                            .padding(.top, 25)
                    }
                }.background(Color.white.opacity(0.5))
            }
        }
    }
}

struct Notification_Previews: PreviewProvider {
    static var previews: some View {
        Notification()
    }
}
