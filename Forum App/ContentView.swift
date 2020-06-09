//
//  ContentView.swift
//  Forum App
//
//  Created by MacBook Pro on 3/11/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var status = (Auth.auth().currentUser != nil)
    var body: some View {
        VStack {
            if self.status {
                Tabbar(status: $status)
            } else {
                AuthView(status: $status)
            }
        }.animation(.spring())
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}




