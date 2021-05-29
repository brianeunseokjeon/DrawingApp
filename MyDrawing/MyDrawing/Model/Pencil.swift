//
//  Pencil.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/28.
//

import UIKit
protocol PencilType {
    var tag: Int {get}
    var color: UIColor {get}
    var image: UIImage {get}
}

struct Black: PencilType {
    var image: UIImage = #imageLiteral(resourceName: "Black")
    var tag = 0
    var color: UIColor = .black
}
struct Gray: PencilType {
    var tag = 1
    var color: UIColor = .gray
    var image: UIImage = #imageLiteral(resourceName: "Grey")
}
struct Red: PencilType {
    var tag = 2
    var color: UIColor = .red
    var image: UIImage = #imageLiteral(resourceName: "Red")
}
struct Orange: PencilType {
    var tag = 3
    var color: UIColor = .orange
    var image: UIImage = #imageLiteral(resourceName: "DarkOrange")
}
struct Yellow: PencilType {
    var tag = 4
    var color: UIColor = .yellow
    var image: UIImage = #imageLiteral(resourceName: "Yellow")
}
struct Green: PencilType {
    var tag = 5
    var color: UIColor = .green
    var image: UIImage = #imageLiteral(resourceName: "DarkGreen")
}
struct Blue: PencilType {
    var tag = 6
    var color: UIColor = .blue
    var image: UIImage = #imageLiteral(resourceName: "Blue")
}
//struct Indigo: PencilType {
//    var tag = 7
//    var color: UIColor = .systemIndigo
//    var image: UIImage = #imageLiteral(resourceName: "Grey")
//}
//struct Purple: PencilType {
//    var tag = 8
//    var color: UIColor = .purple
//    var image: UIImage = #imageLiteral(resourceName: "Grey")
//}
struct Eraser: PencilType {
    var tag: Int = 7
    var color: UIColor = .white
    var image: UIImage = #imageLiteral(resourceName: "Eraser")
}

struct Pencil {
    let set: [PencilType] = [Black(),Gray(),Red(),Orange(),Yellow(),Green(),Blue(),Eraser()]
}

