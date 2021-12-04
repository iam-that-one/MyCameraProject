//
//  TakingPicView.swift
//  TakePicture
//
//  Created by Abdullah Alnutayfi on 02/12/2021.
//

import UIKit

class TakingPicView: UIViewController {
    var viewModel = ViewModel()
    var name : String?
    var images : [UIImage] = []
    var singleImage = UIImage()
    lazy var saveBtn : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "square.and.arrow.down.on.square"), for: .normal)
        $0.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector (saveBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var savedImagesGrid : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "square.grid.3x3"), for: .normal)
        $0.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector (savedImagesBtnClick), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    
    lazy var close : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(systemName: "x.square.fill"), for: .normal)
        $0.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.tintColor = .black
        $0.addTarget(self, action: #selector (dimissView), for: .touchDown)
        return $0
    }(UIButton(type: .system))
    
    lazy var takePicBtnClic : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(named: "btn"), for: .normal)
        $0.setTitle("Take a photo", for: .normal)
        $0.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.addTarget(self, action: #selector (takePhotoBtnClick), for: .touchDown)
        $0.tintColor = .black
        return $0
    }(UIButton(type: .system))
    
    lazy var image : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(systemName: "photo.on.rectangle.angled")
        $0.tintColor = .darkGray
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    lazy var nameLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var subView : UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.systemGray3
        $0.layer.cornerRadius = 10
        
        return $0
    }(UIView())
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        nameLable.text = name
        super.viewDidLoad()
        subView.addSubview(image)
        uiSettings()
    }
    
    private func uiSettings(){
        view.backgroundColor = .lightGray
    
        [subView,nameLable,takePicBtnClic,close,savedImagesGrid,saveBtn].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
        savedImagesGrid.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        savedImagesGrid.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
        savedImagesGrid.heightAnchor.constraint(equalToConstant: 60),
        savedImagesGrid.widthAnchor.constraint(equalToConstant: 60),
        
        nameLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 20),
        nameLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        close.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
        close.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        close.heightAnchor.constraint(equalToConstant: 60),
        close.widthAnchor.constraint(equalToConstant: 60),
        
        subView.topAnchor.constraint(equalTo: nameLable.bottomAnchor,constant: 20),
        subView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        subView.heightAnchor.constraint(equalToConstant: 500),
        subView.widthAnchor.constraint(equalToConstant: 300),
        
        image.topAnchor.constraint(equalTo: subView.topAnchor),
        image.bottomAnchor.constraint(equalTo: subView.bottomAnchor),
        image.trailingAnchor.constraint(equalTo: subView.trailingAnchor),
        image.leadingAnchor.constraint(equalTo: subView.leadingAnchor),

        saveBtn.topAnchor.constraint(equalTo: subView.bottomAnchor,constant: 5),
        saveBtn.centerXAnchor.constraint(equalTo: subView.centerXAnchor),
        saveBtn.heightAnchor.constraint(equalToConstant: 60),
        saveBtn.widthAnchor.constraint(equalToConstant: 60),
        
       // takePicBtnClic.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 20),
        takePicBtnClic.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
        takePicBtnClic.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
        takePicBtnClic.heightAnchor.constraint(equalToConstant: 80),
        takePicBtnClic.widthAnchor.constraint(equalToConstant: 300),
        takePicBtnClic.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -20),
        ])
    }
    
    // open Camrea
    
    @objc func takePhotoBtnClick(){
        let cameraController = UIImagePickerController()
        cameraController.sourceType = .camera
        cameraController.allowsEditing = true
        cameraController.delegate = self
        present(cameraController, animated: true)
    }
    
    // close TakePicView
    
    @objc func dimissView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // save photo to coreData
    
    @objc func saveBtnClick(){
        let newImage = MyImages(context: viewModel.getContext())
        if singleImage == UIImage(){
            return
        }
        let dataImage = singleImage.pngData()
        newImage.image = dataImage
        
        do{
            try viewModel.getContext().save()
        }catch let error as NSError{
            print("Something went wrong while trying to save the image \(error.userInfo)")
        }
    }
    
    // Move to Grids View
    
    @objc func savedImagesBtnClick(){
        let savedImagesGrids = SavedImagesGrids()
        viewModel.fetchData()
        savedImagesGrids.data = viewModel.myimages
        self.present(savedImagesGrids, animated: true, completion: nil)
    }
}
