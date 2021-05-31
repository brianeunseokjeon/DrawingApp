//
//  ViewController.swift
//  MyDrawing
//
//  Created by brian은석 on 2021/05/28.
//

import UIKit
import func AVFoundation.AVMakeRect

class MainViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var drawingView: DrawingView!
    private let model = DrawingModel()
    
    @IBOutlet weak var penBottomLayout: NSLayoutConstraint!
    private let imagePikcerController = UIImagePickerController()
    
    // MARK: - ViewLifyCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        settingUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        drawingView.myDraw()
    }
    
    // MARK: - Setting
    private func settingUI() {
        imagePikcerController.delegate = self
        view.backgroundColor = .white
        drawingView.model = model
    }
    
    // MARK: - Button Action
    
    @IBAction func saveAction(_ sender: Any) {
        model.saveCoreDataLines()
        let drawingSize = drawingView.bounds.size
        
        let size = backgroundImageView.calculateRectOfImageInImageView()
        
        let image = model.saveDrawing(drawingSize: drawingSize,imageCGRect: size, backgroundImage: backgroundImageView.image) ?? UIImage()
        DispatchQueue.global().async {
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.imageSaved(_:didFinishSavingWithError:contextType:)), nil)
        }
    }
    //불러오기
    @IBAction func loadAction(_ sender: UIButton) {
        DrawSaveDataManager.shared.getData()
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoadViewController") as! LoadViewController
        vc.model = model
        vc.loadDrawingUpdateDelegate = self
        present(vc, animated: true, completion: nil)
    }
    //그림추가
    @IBAction func backgroundAdd(_ sender: UIButton) {
        imagePikcerController.sourceType = .photoLibrary
        present(imagePikcerController, animated: true, completion: nil)
        
    }
    @IBAction func undoAction(_ sender: UIButton) {
        drawingView.undoDraw()
    }
    
    @IBAction func redoAction(_ sender: UIButton) {
        drawingView.redoDraw()
    }
    
    @IBAction func showUpPenAndErase(_ sender: UIButton) {
        if model.isPenOpen {
            model.isPenOpen = false
            UIView.animate(withDuration: 0.3) {
                self.penBottomLayout.constant = -180
                self.view.layoutIfNeeded()
            } completion: { (_) in
                self.collectionView.isHidden = true
            }
        } else {
            model.isPenOpen = true
            self.collectionView.isHidden = false
            
            UIView.animate(withDuration: 0.3) {
                self.penBottomLayout.constant = 0
                self.view.layoutIfNeeded()
            }
            
        }
        
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        //1.0.1
        backgroundImageView.image = nil
        drawingView.clearDraw()
    }
    
    // MARK: - Objc
    @objc func imageSaved(_ image: UIImage, didFinishSavingWithError error:Error?, contextType: UnsafeRawPointer) {
        if let error = error {
            print("DEBUG : Unable Image save",error.localizedDescription)
        } else {
            print("Image saved Success")
        }
    }
    deinit {
        print("Main Deinit")
    }
    
}

// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return model.pencilSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "penCell", for: indexPath) as! ImageCollectionViewCell
        cell.penImageView.image = model.pencilSet[indexPath.row].image
        return cell
    }
    
    
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 20, height: 160)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        model.pencilSelect(indexPath.row)
    }
}

// MARK: - ImagePickerDelegate
extension MainViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            //1.0.1 이미지뷰에 바로 넣으면 될듯
            backgroundImageView.image = image
            drawingView.myDraw()
        }
        dismiss(animated: true, completion: nil)
    }
}

extension MainViewController: LoadDrawingHelpable {
    func updateDraw() {
        drawingView.myDraw()
    }
}


