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


//extension UIImage {
//    func resized(toWidth width: CGFloat, interpolationQuality: CGInterpolationQuality = .none) -> CGContext {
//        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
//        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
////        defer { UIGraphicsEndImageContext() }
//        guard let context = UIGraphicsGetCurrentContext() else { return UIGraphicsGetCurrentContext()! }
//        context.interpolationQuality = interpolationQuality
//        draw(in: CGRect(origin: .zero, size: canvasSize))
//        return context
//    }
//}
