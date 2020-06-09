//
//  TopBar.swift
//  Forum App
//
//  Created by MacBook Pro on 3/23/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct TopBar: View {
    @Binding var selected : Int
    @Binding var show : Bool
    var body: some View {
        VStack (spacing: 20) {
            HStack {
                Text("Alearts").font(.system(size:20 )).fontWeight(.semibold).foregroundColor(.black)
                Spacer()
                Button(action: {
                    withAnimation {
                        self.show.toggle()
                    }
                }) {
                    Image(systemName: "person.3.fill").font(.headline).foregroundColor(.black)
                }
            }
            HStack {
                Button(action: {
                    self.selected = 0
                }) {
                    Text("Notification").fontWeight(.semibold).foregroundColor(self.selected == 0 ? .white : .black)
                }
                Spacer(minLength: 8)
                Button(action: {
                    self.selected = 1
                }) {
                    Text("Request Friend").fontWeight(.semibold).foregroundColor(self.selected == 1 ? .white : .black)
                }
            }.padding(.top)
        }
        .padding()
        .padding(.top, (UIApplication.shared.windows.last?.safeAreaInsets.top)! + 10)
        .background(Color.white.opacity(0.6))
    }
}
