//
//  Extension.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/29.
//

import UIKit

extension UIView {
    func takeScreenShot() -> UIImage {
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        defer { UIGraphicsEndImageContext() }
        if let image = image {
            return image
        }
        return UIImage()
    }
}


extension DateFormatter {
    func myFormatter() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy년 M월 dd일 HH시 mm분"
        return df
    }
}


extension UIImageView {
    func calculateRectOfImageInImageView() -> CGRect {
        let imageViewSize = self.frame.size
        let imgSize = self.image?.size
        
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
        
        
        return imageRect
    }

}



