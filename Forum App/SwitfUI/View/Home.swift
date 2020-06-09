//
//  Home.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct Home : View {
    
    @EnvironmentObject var observedData : getData
    @EnvironmentObject var user : UserServices
    private let uid = Auth.auth().currentUser?.uid
    var body : some View{
        
        NavigationView {
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(alignment: .leading){
                        
                        ForEach(observedData.datas){i in
                            
                            PostCellTop(name: i.name, id: i.tagId, pic: i.pic, image: i.url, msg: i.msg,uid: i.uid)
                            
                            if i.pic != ""{
                                
                                PostCellMidle(pic: i.pic).padding(.leading, 60)
                                
                            }
                            PostCellBottom(id: i.id, countLike: Int(i.likes)!,isFill: i.uidLikes.contains(self.uid!),uidLikes: i.uidLikes ,name: self.user.datas.name,uidPost:i.uid ).offset(x: UIScreen.main.bounds.width / 4)
                        }
                    }
                    
                }.padding(.bottom, 15)

            .navigationBarTitle("Home",displayMode: .inline)
        }
    }
}
