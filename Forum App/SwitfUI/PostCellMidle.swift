//
//  PostCellMidle.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI


struct PostCellMidle : View {
    
    var pic = ""
    
    var body : some View{
        
        AnimatedImage(url: URL(string: pic)!).resizable().frame(height: 300).cornerRadius(20).padding()
    }
}

