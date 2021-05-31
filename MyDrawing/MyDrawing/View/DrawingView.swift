//
//  DrawingView.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/28.
//

import UIKit

class DrawingView: UIView {
    
    var model: DrawingGUIProtocol?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        model?.draw(size: rect, image: nil)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        model?.touchesBeganDrawingLineAppend()
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first?.location(in: self) else {
            return
        }
        model?.touchesMoved(touch, completion: {
            setNeedsDisplay()
        })
        
    }
    
    func myDraw() {
        setNeedsDisplay()
    }
    
    
    func undoDraw() {
        model?.undoDrawing {
            setNeedsDisplay()
        }
    }
    
    func redoDraw() {
        model?.redoDrawing {
            setNeedsDisplay()
        }
    }
    
    func clearDraw() {
        model?.clearDrawingView {
            setNeedsDisplay()
        }
    }
}
