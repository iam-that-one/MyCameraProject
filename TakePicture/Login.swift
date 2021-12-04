//
//  ViewController.swift
//  TakePicture
//
//  Created by Abdullah Alnutayfi on 02/12/2021.
//

import UIKit

class Login: UIViewController {
var viewModel = UserViewModel()
    var images: [UIImage] = []
  
    lazy var launchScreen : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "pngwing.com")
        return $0
    }(UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 200)))
    lazy var loginBtn : UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setBackgroundImage(UIImage(named: "btn"), for: .normal)
        $0.setTitle("Login", for: .normal)
        $0.titleLabel?.font =  UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.addTarget(self, action: #selector (loginBtnClick), for: .touchDown)
        $0.tintColor = .black
        return $0
    }(UIButton(type: .system))
    lazy var passwordTf : UITextField = {
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Password"
        $0.isSecureTextEntry = true
        $0.text = "qwertyuio"
        $0.backgroundColor = .darkGray
        $0.textAlignment = .left
    
        return $0
    }(UITextField())
    
    lazy var passwordLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Password"
        $0.textColor = .white
        $0.textAlignment = .left
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
    
        return $0
    }(UILabel())
    
    lazy var nameTf : UITextField = {
        $0.borderStyle = .roundedRect
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.placeholder = "Name"
        $0.text = "Abdullah"
        $0.backgroundColor = .darkGray
        $0.textAlignment = .left
    
        return $0
    }(UITextField())
    
    lazy var nameLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "Name"
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return $0
    }(UILabel())
    
    lazy var appLable : UILabel = {
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "CaptureIt"
        $0.textAlignment = .center
        $0.font = UIFont(name: "Charter Roman", size: 40)
        $0.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        $0.textColor = .white
        return $0
    }(UILabel())
    
    lazy var logo : UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.image = UIImage(named: "pngwing.com")
        $0.tintColor = .white
        return $0
    }(UIImageView())
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to dismiss the keyboard when tappin the main vies. Look to the login extension for the function "dismissKeyboard"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        // to restore the default rotation status or make a custom rotation.
        //(UIApplication.shared.delegate as! AppDelegate).restrictRotation = .all
        
        // establishing logo animation
        self.rotateView(targetView: logo, duration: 5)
        
        // observe the keyboard status. If will show, the function (keyboardWillShow) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil)

        // observe the keyboard status. If will Hide, the function (keyboardWillHide) will be excuted.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        // Main view background
        view.backgroundColor = UIColor(patternImage: UIImage(named: "image3")!)
        
        //Add launch screen to the main view
        view.addSubview(launchScreen)
        
        // Take the Photos from Assest folder and append it to the images array.
        for  i in 1...7 {
            images.append(UIImage(named: "image\(i)")!)
        }
    
        // Make the appearance of Photos in the array "images" as animated.
        let animation = UIImage.animatedImage(with: images, duration: 1)
        
        //Add the animated Photos to the imageView "launchScreen"
        self.launchScreen.image = animation

        
        // AutoLayout
        launchScreen.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        launchScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        launchScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        launchScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
       
        // Applaying threading to control the flow of the transtion from launch screen to the main screen.
        DispatchQueue.main.asyncAfter(deadline: .now()+2.0, execute: {
            self.launchScreen.removeFromSuperview() // remove launchScreen from thw main view
            self.uiSettings()
        })
    }
    
    // Hide Navigation bar
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    func uiSettings(){
        
        [appLable,logo,nameLable,nameTf,passwordLable,passwordTf,loginBtn,nameLable].forEach{view.addSubview($0)}
        NSLayoutConstraint.activate([
            appLable.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 100),
            appLable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLable.widthAnchor.constraint(equalToConstant: 300),
            
            logo.topAnchor.constraint(equalTo: appLable.bottomAnchor, constant: 30),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 200),
            logo.widthAnchor.constraint(equalToConstant: 200),
            
            nameLable.topAnchor.constraint(equalTo: logo.bottomAnchor,constant: 40),
            nameLable.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            
            nameTf.topAnchor.constraint(equalTo: nameLable.bottomAnchor,constant: 20),
            nameTf.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            nameTf.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            passwordLable.topAnchor.constraint(equalTo: nameTf.bottomAnchor,constant: 20),
            passwordLable.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),

            passwordTf.topAnchor.constraint(equalTo: passwordLable.bottomAnchor,constant: 20),
            passwordTf.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            passwordTf.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            
            loginBtn.topAnchor.constraint(equalTo: passwordTf.bottomAnchor,constant: 20),
            loginBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 20),
            loginBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -20),
            loginBtn.heightAnchor.constraint(equalToConstant: 80),
            loginBtn.widthAnchor.constraint(equalToConstant: 300),
        ])
    }
}

