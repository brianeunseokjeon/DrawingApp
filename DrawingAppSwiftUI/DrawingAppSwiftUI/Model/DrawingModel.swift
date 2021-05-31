//
//  DrawingModel.swift
//  DrawingAppSwiftUI
//
//  Created by brian은석 on 2021/05/30.
//

import UIKit

public final class DrawingEntity: NSObject, NSCoding {
    public func encode(with coder: NSCoder) {
        coder.encode(color, forKey: "color")
        coder.encode(width, forKey: "width")
        coder.encode(opacity, forKey: "opacity")
        coder.encode(points, forKey: "points")
        
    }
    public override init() { }
    
    public init?(coder: NSCoder) {
        guard let color = coder.decodeObject(forKey: "color") as? UIColor,
              let width = coder.decodeObject(forKey: "width") as? CGFloat,
              let opacity = coder.decodeObject(forKey: "opacity") as? CGFloat,
              let points = coder.decodeObject(forKey: "points") as? [CGPoint] else {return}
        self.color = color
        self.width = width
        self.opacity = opacity
        self.points = points
        
    }
    
    var color: UIColor = .black
    var width: CGFloat = 1.0
    var opacity: CGFloat = 1.0
    var points: [CGPoint] = []
    
}

protocol DrawingGUIProtocol: class {
    func draw(size:CGRect,image:UIImage?)
    func touchesBeganDrawingLineAppend()
    func touchesMoved(_ location:CGPoint,completion:()->())
    func clearDrawingView(completion:()->())
    func undoDrawing(completion:()->())
    func redoDrawing(completion:()->())
    func loadDrawing(_ entity:[DrawingEntity])
}



protocol PencilGUIProtocol {
    var pencilSet: [PencilType] {get}
    var currentColor: UIColor {get set}
    var currentWidth: CGFloat {get set}
    var currentOpacity: CGFloat {get set}
    func pencilSelect(_ tag:Int)
}

final class DrawingModel:DrawingGUIProtocol ,PencilGUIProtocol {
    private var drawingLines = [DrawingEntity]()
    private var drawedLines = [DrawingEntity]()
    private let imageSaver = ImageSaver()
    
    let pencilSet: [PencilType] = Pencil().set
    var currentColor: UIColor = .black
    var currentWidth: CGFloat = 10.0
    var currentOpacity: CGFloat = 1.0
    
    func pencilSelect(_ tag: Int) {
        currentColor = pencilSet[tag].color
    }
    
    var isLoadDismiss = false
    
    //    var image: UIImage?
    
    func draw(size: CGRect,image: UIImage? = nil) {
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
        guard let lastPoint = drawingLines.popLast() else {return}
        lastPoint.points.append(location)
        lastPoint.color = currentColor
        lastPoint.width = currentWidth
        lastPoint.opacity = currentOpacity
        drawingLines.append(lastPoint)
        completion()
    }
    
    func clearDrawingView(completion:()->()) {
        //        image = nil
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
    
    func loadDrawing(_ entity: [DrawingEntity]) {
        isLoadDismiss = true
        drawingLines = entity
        drawedLines.removeAll()
    }
    // image + line
    func saveDrawing(drawingSize: CGSize,imageCGRect: CGRect,backgroundImage: UIImage?) -> UIImage? {
        UIGraphicsBeginImageContext(drawingSize)
        draw(size: imageCGRect,image: backgroundImage)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        defer { UIGraphicsEndImageContext() }
        return image
    }
    
    //only line save
    func saveCoreDataLines() {
        DrawSaveDataManager.shared.save(lines: drawingLines)
    }
    
    // line save + ( image + line in photo album)
    func saveDrawingAndwriteToPhotoAlbum(drawingSize: CGSize,imageCGRect: CGRect,backgroundImage: UIImage?) {
        saveCoreDataLines()
        let image = saveDrawing(drawingSize:drawingSize,imageCGRect: imageCGRect,backgroundImage: backgroundImage) ?? UIImage()
        imageSaver.writeToPhotoAlbum(image: image)
    }
    
    
    
    
}


