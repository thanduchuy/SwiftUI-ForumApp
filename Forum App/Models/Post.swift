//
//  Post.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Post : Identifiable {
    var uid: String
    var id : String
    var name : String
    var msg : String
    var likes : String
    var pic : String
    var url : String
    var repost : String
    var tagId : String
    var uidLikes : [String]
}

