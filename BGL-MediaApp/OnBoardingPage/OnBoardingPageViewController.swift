//
//  OnBoardingPageViewController.swift
//  BGL-MediaApp
//
//  Created by Victor Ma on 21/6/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class OnBoardingPageViewController: UIViewController {
    var label = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

    }
    
    
    var button = UIButton()
    var registerButton = UIButton()
    var loginButton = UIButton()
    
    func createLabel(text: String){
        let offset = 5
        label.frame = CGRect(x: CGFloat(offset), y: UIScreen.main.bounds.height*3/5, width: UIScreen.main.bounds.width-CGFloat(offset*2), height: UIScreen.main.bounds.height/2)
        label.text = text
        label.textColor = .white
        label.clipsToBounds = true
        label.numberOfLines = 0
        self.view.addSubview(label)
    }
    
    func createImage(from pid: Int){
        var image: UIImage!
        if pid != 1 {
            image = UIImage(named: "\(pid).png")
        } else {
            image = UIImage(named: "bcg_logo.png")
        }
        let imageView = UIImageView(image: image)
        let distanceToTop = 80
        let width = UIScreen.main.bounds.width
        let imageFrame = CGRect(origin: CGPoint(x: (width-image.size.width)/2, y: CGFloat(distanceToTop)), size: image.size)
        imageView.frame = imageFrame
        view.addSubview(imageView)
    }
    
    func createButton(from pid:Int){
        if pid != 1 {//create skip button
            button.setTitle("SKIP THESE", for: .normal)
            button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 10)
            button.titleLabel?.textColor = .white
            button.backgroundColor = .lightGray
            button.addTarget(self, action: #selector(skipButtonClicked), for: .touchUpInside)
            let buttonFrame = CGRect(x: (UIScreen.main.bounds.width-CGFloat(100))/2, y: UIScreen.main.bounds.height*3/5 + CGFloat(50), width: CGFloat(100), height: CGFloat(50))
            button.frame = buttonFrame
            view.addSubview(button)
        } else{
            
            registerButton.setTitle("Register", for: .normal)
            registerButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
            registerButton.titleLabel?.textColor = .white
            registerButton.backgroundColor = .lightGray
            registerButton.addTarget(self, action: #selector(registerButtonClicked), for: .touchUpInside)
            let registerButtonFrame = CGRect(x: CGFloat(50), y: UIScreen.main.bounds.height*3/5 + CGFloat(50), width: CGFloat(100), height: CGFloat(50))
            registerButton.frame = registerButtonFrame
            
            loginButton.setTitle("Login", for: .normal)
            loginButton.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 15)
            loginButton.titleLabel?.textColor = .white
            loginButton.backgroundColor = .lightGray
            loginButton.addTarget(self, action: #selector(loginButtonClicked), for: .touchUpInside)
            let loginButtonFrame = CGRect(x: UIScreen.main.bounds.width - CGFloat(150), y: UIScreen.main.bounds.height*3/5 + CGFloat(50), width: CGFloat(100), height: CGFloat(50))
            loginButton.frame = loginButtonFrame
            view.addSubview(registerButton)
            view.addSubview(loginButton)
        }
        
    }
    @objc func registerButtonClicked(sender: UIButton){
        
    }
    
    @objc func loginButtonClicked(sender: UIButton){
        
    }
    
    
    @objc func skipButtonClicked(sender: UIButton){
        let vc:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomePage") as UIViewController
        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
        
        
        vc.modalTransitionStyle = .flipHorizontal
//        vc.modalTransitionStyle = .crossDissolve

        
        self.present(vc, animated: true, completion: nil)
        
    }
    

        
    init(backgroundColor: UIColor, text: String, pid: Int){
        super.init(nibName: nil, bundle: nil)
        self.view.backgroundColor = backgroundColor
        createLabel(text: text)
        createImage(from: pid)
        createButton(from: pid)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
