//
//  Alert.swift
//  Forum App
//
//  Created by MacBook Pro on 3/23/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct Alert: View {
    @EnvironmentObject var data : NotificationService
    var body: some View {
        VStack {
            HStack {
                Text("Alert...").font(.largeTitle).fontWeight(.heavy).foregroundColor(.black)
                Spacer()
            }.padding().background(Color.white).cornerRadius(10)
            Image(systemName: "flame").resizable().frame(width: 40, height: 40).padding(10).background(Color.red).clipShape(Circle()).offset( y: -60).padding(.bottom,-55)
            Spacer()
            if data.data.count == 0 {
                Image("notifi").resizable().frame(width: 200, height: 200).clipShape(Circle())
                Spacer()
            } else {
                ScrollView {
                    ForEach(data.data) { item in
                        if item.isLike {
                            HStack  {
                                VStack (alignment: .leading) {
                                    Text(item.name).font(.subheadline)
                                    Text(item.msg).font(.title).fontWeight(.semibold)
                                }
                                Spacer()
                                Text(item.date).font(.caption).fontWeight(.bold)
                            }.padding(10).background(Color.white).foregroundColor(.black).cornerRadius(UIScreen.main.bounds.height/2).padding(.bottom,10)
                        } else if item.isMakeFriend {
                            VStack( spacing: 10) {
                                Text(item.name).font(.subheadline)
                                Text(item.msg).font(.title).fontWeight(.semibold)
                                Spacer()
                                Text(item.date).font(.caption).fontWeight(.bold)
                            }.frame(width: UIScreen.main.bounds.width).background(Color.blue).foregroundColor(.white).cornerRadius(20).padding(.bottom,10)
                        } else  {
                            HStack  {
                                VStack (alignment: .leading) {
                                    Text(item.name).font(.subheadline)
                                    Text(item.msg).font(.headline).fontWeight(.semibold)
                                }
                                Spacer()
                                Text(item.date).font(.caption).fontWeight(.bold)
                            }.padding(15).border(Color.white, width: 2).foregroundColor(.white).padding(.bottom,10)
                        }
                    }
                }
            }
        }.padding(.top, -14)
    }
}

struct Alert_Previews: PreviewProvider {
    static var previews: some View {
        Alert()
    }
}
