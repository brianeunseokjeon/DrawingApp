//
//  ImageCollectionViewCell.swift
//  DrawingAppSwiftUI
//
//  Created by brian은석 on 2021/05/30.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    let penImageView = UIImageView()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    var penImageViewHeight: NSLayoutConstraint!
    
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
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeUI() {
        let containView = UIView()
        contentView.addSubview(containView)
        containView.translatesAutoresizingMaskIntoConstraints = false
        containView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        containView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        containView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        containView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        containView.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        contentView.addSubview(penImageView)
        penImageView.translatesAutoresizingMaskIntoConstraints = false
        penImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        penImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        penImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        penImageViewHeight = penImageView.heightAnchor.constraint(equalToConstant: 120)
        penImageViewHeight.isActive = true
    }
}
