//
//  SearchBar.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct SearchBar : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let search = UISearchBar()
        return search
    }
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        
    }
} 
