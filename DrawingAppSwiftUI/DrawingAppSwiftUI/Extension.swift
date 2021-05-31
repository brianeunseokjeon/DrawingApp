//
//  Extension.swift
//  DrawingAppSwiftUI
//
//  Created by brian은석 on 2021/05/31.
//

import UIKit

extension DateFormatter {
    func myFormatter() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "yyyy년 M월 dd일 HH시 mm분"
        return df
    }
}



