//
//  LoadViewController.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/29.
//

import UIKit

protocol LoadDrawingHelpable: class {
    func updateDraw()
}

class LoadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var listTableView: UITableView!
    var model: DrawingModel?
    weak var loadDrawingUpdateDelegate: LoadDrawingHelpable?
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return DrawSaveDataManager.shared.histories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SaveLinesTableViewCell", for: indexPath) as! SaveLinesTableViewCell
        let data = DrawSaveDataManager.shared.histories[indexPath.row]
        cell.settingUI(lines: data.saveDrawing, date: data.saveDate)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let data = DrawSaveDataManager.shared.histories[indexPath.row].saveDrawing else {return}
        model?.loadDrawing(data)
        loadDrawingUpdateDelegate?.updateDraw()
        dismiss(animated: true, completion: nil)
    }
    deinit {
        print("Load Deinit")
    }
}


