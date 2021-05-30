//
//  ImageSaver.swift
//  DrawingAppSwiftUI
//
//  Created by brian은석 on 2021/05/30.
//

import UIKit

final class ImageSaver: NSObject {
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(imageSaved), nil)
    }

    @objc private func imageSaved(_ image: UIImage, didFinishSavingWithError error:Error?, contextType: UnsafeRawPointer) {
        if let error = error {
            print("DEBUG : Unable Image save",error.localizedDescription)
        } else {
            print("Image saved Success")
        }
    }
}
