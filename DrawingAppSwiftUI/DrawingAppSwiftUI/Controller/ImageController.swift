//
//  ImageController.swift
//  DrawingAppSwiftUI
//
//  Created by brian은석 on 2021/05/30.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    @Binding var model: DrawingModel
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
           return Coordinator(picker: self)
       }
}


class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: ImagePickerView
    
    init(picker: ImagePickerView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        self.picker.model.image = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
    
}
