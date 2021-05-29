//
//  DrawingModel.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/28.
//

import UIKit

struct DrawingEntity {
    var color: UIColor = .black
    var width: CGFloat = 1.0
    var opacity: CGFloat = 1.0
    var points: [CGPoint] = []
}

protocol DrawingGUIProtocol {
    func draw(size:CGRect)
    func touchesBeganDrawingLineAppend()
    func touchesMoved(_ location:CGPoint,completion:()->())
    func clearDrawingView(completion:()->())
    func undoDrawing(completion:()->())
    func redoDrawing(completion:()->())
}

protocol PencilGUIProtocol {
    var pencilSet: [PencilType] {get}
    var currentColor: UIColor {get set}
    var currentWidth: CGFloat {get set}
    var currentOpacity: CGFloat {get set}
    func pencilSelect(_ tag:Int)
}

class DrawingModel:DrawingGUIProtocol ,PencilGUIProtocol {
    private var drawingLines = [DrawingEntity]()
    private var drawedLines = [DrawingEntity]()
    
    let pencilSet = Pencil().set
    
    var currentColor: UIColor = .black
    var currentWidth: CGFloat = 10.0
    var currentOpacity: CGFloat = 1.0
    
    func pencilSelect(_ tag:Int) {
        currentColor = pencilSet[tag].color
    }
    
    var image: UIImage?
    
    func draw(size:CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else {
            return
        }

        if let image = image {
            image.draw(in: size)
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
    
    func touchesBeganDrawingLineAppend() {
        drawedLines.removeAll()
        drawingLines.append(DrawingEntity())
    }
    
    func touchesMoved(_ location:CGPoint,completion:()->()) {
        guard var lastPoint = drawingLines.popLast() else {return}
        lastPoint.points.append(location)
        lastPoint.color = currentColor
        lastPoint.width = currentWidth
        lastPoint.opacity = currentOpacity
        drawingLines.append(lastPoint)
        completion()
    }
    
    func clearDrawingView(completion:()->()) {
        image = nil
        drawingLines.removeAll()
        completion()
    }
    
    func undoDrawing(completion:()->()) {
        if drawingLines.count > 0 {
           let drawedLine = drawingLines.removeLast()
            drawedLines.append(drawedLine)
            completion()
        }
    }
    
    func redoDrawing(completion: () -> ()) {
        if drawedLines.count > 0 {
           let redoLine = drawedLines.removeLast()
            drawingLines.append(redoLine)
            completion()
        }
    }
    
    
    
    func saveDrawing(_ size:CGRect) -> UIImage? {
        UIGraphicsBeginImageContext(size.size)
        draw(size: size)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        defer { UIGraphicsEndImageContext() }
        return image
    }
}


