//
//  Search.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Search : View {
    
    @EnvironmentObject var datas : getData
    
    var body : some View {
        NavigationView {
            ZStack(alignment: .top) {
                GeometryReader { _ in
                    Text("")
                }.background(Color.black).edgesIgnoringSafeArea(.all)
                CustomSearchBar(data: $datas.datas).padding(.top)
            }
            .navigationBarTitle("Search",displayMode: .inline)
        }
    }
}

