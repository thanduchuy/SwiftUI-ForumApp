//
//  imagePicker.swift
//  Forum App
//
//  Created by MacBook Pro on 3/15/20.
//  Copyright © 2020 MacBook Pro. All rights reserved.
//

import SwiftUI

struct imagePicker : UIViewControllerRepresentable {
    
    
    
    @Binding var picked : Bool
    @Binding var picData : Data
    
    func makeCoordinator() -> imagePicker.Coordinator {
        imagePicker.Coordinator(parent1: self)
    }
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> UIImagePickerController{
        let image = UIImagePickerController()
        image.sourceType = .photoLibrary
        image.delegate = context.coordinator
        return image
    }
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
        
    }
    
    class Coordinator : NSObject,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
        var parent : imagePicker
        init(parent1: imagePicker) {
            parent = parent1
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            self.parent.picked.toggle()
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let img = info[.originalImage] as! UIImage
            let picdata = img.jpegData(compressionQuality: 0.25)
            self.parent.picData = picdata!
            self.parent.picked.toggle()
        }
    }
    
}

