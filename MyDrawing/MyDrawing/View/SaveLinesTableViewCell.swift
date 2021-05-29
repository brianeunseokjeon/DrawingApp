//
//  SaveLinesTableViewCell.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/29.
//

import UIKit

class SaveLinesTableViewCell: UITableViewCell {

    @IBOutlet weak var linesPreview: DrawingPreview!
    @IBOutlet weak var makeDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func settingUI(lines:[DrawingEntity]?,date:Date?) {
        guard let lines = lines , let date = date else {return}
        let dateformatter = DateFormatter().myFormatter()
        makeDateLabel.text = dateformatter.string(from: date)
        linesPreview.drawingLines = lines
        linesPreview.myDraw()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


