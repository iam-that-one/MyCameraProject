//
//  SavedImagesGrids.swift
//  TakePicture
//
//  Created by Abdullah Alnutayfi on 03/12/2021.
//

import UIKit

class SavedImagesGrids: UIViewController {
    var data : [MyImages]?
    
    var imagesCollectionView : UICollectionView? = nil
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "image3")!)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
               layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
               layout.itemSize = CGSize(width: 100, height: 100)
        
        imagesCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        imagesCollectionView!.backgroundColor = UIColor.white
        imagesCollectionView!.dataSource = self
        imagesCollectionView!.delegate = self
        imagesCollectionView!.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "coleectionViewCell")
        view.addSubview(imagesCollectionView!)

        NSLayoutConstraint.activate([
            imagesCollectionView!.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagesCollectionView!.leadingAnchor.constraint(equalTo: view.leadingAnchor),

            imagesCollectionView!.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            imagesCollectionView!.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

