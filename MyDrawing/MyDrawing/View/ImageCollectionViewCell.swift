//
//  ImageCollectionViewCell.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/28.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var penImageView: UIImageView!
    @IBOutlet weak var penImageViewHeight: NSLayoutConstraint!
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.3) {[weak self] in
                    self?.penImageViewHeight.constant = 160
                    self?.contentView.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.3) {[weak self] in
                    self?.penImageViewHeight.constant = 120
                    self?.contentView.layoutIfNeeded()
                }
            }
        }
    }
    
    override func prepareForReuse() {
        penImageView.image = nil
    }

}
