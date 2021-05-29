//
//  DrawingPreview.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/30.
//

import UIKit

class DrawingPreview: UIView {
    
    var drawingLines = [DrawingEntity]()
    
    override func draw(_ rect: CGRect) {
        draw(size: rect)
    }
    
    
   private func draw(size:CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }
        drawingLines.forEach { line in
            for (i,p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
                context.setStrokeColor(line.color.withAlphaComponent(line.opacity).cgColor)
                context.setLineWidth(line.width)
            }
            context.setLineCap(.round)
            context.strokePath()
        }
    }
    
    func myDraw() {
        setNeedsDisplay()
    }
}
