//
//  ChatBubble.swift
//  Forum App
//
//  Created by MacBook Pro on 3/20/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct ChatBubble : Shape {
    
    var mymsg : Bool
    
    func path(in rect: CGRect) -> Path {
            
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft,.topRight,mymsg ? .bottomLeft : .bottomRight], cornerRadii: CGSize(width: 16, height: 16))
        
        return Path(path.cgPath)
    }
}
