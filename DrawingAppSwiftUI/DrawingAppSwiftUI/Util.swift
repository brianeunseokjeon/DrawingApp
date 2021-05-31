//
//  Util.swift
//  DrawingAppSwiftUI
//
//  Created by brian은석 on 2021/05/31.
//

import UIKit

final class Util {
    static func calculateRectOfImageInImageView(frameSize: CGSize, imgSize:CGSize?) -> CGRect {
        let imageViewSize = frameSize
    //    let imgSize = imageSize
        
        guard let imageSize = imgSize else {
            return CGRect.zero
        }
        
        let scaleWidth = imageViewSize.width / imageSize.width
        let scaleHeight = imageViewSize.height / imageSize.height
        let aspect = fmin(scaleWidth, scaleHeight)
        let changeImageWidth = imageSize.width * aspect
        let changeImaegHeight = imageSize.height * aspect
        
        var imageRect = CGRect(x: 0, y: 0, width: changeImageWidth, height: changeImaegHeight)
        // Center image
        imageRect.origin.x = (imageViewSize.width - imageRect.size.width) / 2
        imageRect.origin.y = (imageViewSize.height - imageRect.size.height) / 2
        
        // Add imageView offset
        //        imageRect.origin.x += imageView.frame.origin.x
        //        imageRect.origin.y += imageView.frame.origin.y
        
        return imageRect
    }
    
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        let scale = newWidth / image.size.width // 새 이미지 확대/축소 비율
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage ?? UIImage()
    }

}
