//
//  multilineTextFiel.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI


struct multilineTextFiel : UIViewRepresentable {
    
    @Binding var txt : String
    
    func makeCoordinator() -> multilineTextFiel.Coordinator {
        return multilineTextFiel.Coordinator(parent1: self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<multilineTextFiel>) -> UITextView {
        let text = UITextView()
        text.isEditable = true
        text.isUserInteractionEnabled = true
        text.text = "Type Something!!!"
        text.textColor = .gray
        text.font = UIFont.systemFont(ofSize: 20)
        text.delegate = context.coordinator
        return text
    }
    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<multilineTextFiel>) {
        
    }
    class Coordinator : NSObject,UITextViewDelegate {
        var parent : multilineTextFiel
        init(parent1: multilineTextFiel) {
            parent = parent1
        }
        func textViewDidBeginEditing(_ textView: UITextView) {
            textView.text = ""
            textView.textColor = .white
        }
        func textViewDidChange(_ textView: UITextView) {
            self.parent.txt = textView.text
        }
    }
}

