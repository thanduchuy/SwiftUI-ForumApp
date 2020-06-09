//
//  indicator.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI


struct indicator : UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<indicator>) -> UIActivityIndicatorView {
        let indicator1 = UIActivityIndicatorView(style: .large)
        indicator1.startAnimating()
        return indicator1
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<indicator>) {
        
    }
}
