//
//  Extentions.swift
//  TakePicture
//
//  Created by Abdullah Alnutayfi on 04/12/2021.
//

import Foundation
import UIKit

extension SavedImagesGrids : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imagesCollectionView!.dequeueReusableCell(withReuseIdentifier: "coleectionViewCell", for: indexPath) as! MyCollectionViewCell
        cell.image.image = UIImage(data: data![indexPath.row].image ?? Data() )
        return cell
    }
}


extension Login{
    @objc func loginBtnClick(){
        var errerMessage = ""
        var flag = false
        guard let name = nameTf.text else{return}
        guard let password = passwordTf.text else{return}
        do{
      try  checkPasswors(password)
            
    }
        catch let e as MyErrors{
            errerMessage = e.rawValue
        print(e.rawValue)
    }
        catch let error1 as NSError {
        print(error1)
        }
        for user in viewModel.users{
            if user.name == name && user.password == password && errerMessage == ""  {
                flag = true
                break
            }else if errerMessage == ""{
                errerMessage = "User not found or the password does not match the username"
            }
        }
        
        if flag{
            self.view.frame.origin.y = 0
            let takePicView = TakingPicView()
            takePicView.modalPresentationStyle = .fullScreen
            takePicView.name = nameTf.text!
            self.navigationController?.present(takePicView, animated: true, completion: nil)
            }else{
                let alert = UIAlertController(title: "Warning", message: errerMessage , preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
    }
    
    // Move lofin view 300 points upward
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -300
    }

    // Move login view to original position
    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0
    }
    
    func checkPasswors(_ password: String) throws{
        if password.count < 8{
            throw MyErrors.minLength
        }
        if password.count > 20{
            throw MyErrors.maxLength
        }
        if password.first?.isLetter == false{
            throw MyErrors.passwoerdFilestLetter
        }
    }
    
    // rotate the logo
    func rotateView(targetView: UIView, duration: Double = 1.0) {
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveLinear, animations: {
            targetView.transform = targetView.transform.rotated(by: CGFloat(Double.pi))
        }) { finished in
            self.rotateView(targetView: self.logo, duration: duration)
        }
    }
    
    // 
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension TakingPicView : UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    // Image Picker controller
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        self.image.image = image
        self.images.append(image)
        self.singleImage = image
    }
}
