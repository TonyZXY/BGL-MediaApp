//
//  AlertManageController.swift
//  BGL-MediaApp
//
//  Created by Bruce Feng on 22/6/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

struct ExpandableNames{
    var isExpanded:Bool
    let name:[String]
}

class AlertManageController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    
    var twoDimension = [ExpandableNames(isExpanded: true, name: ["a","sf"]),ExpandableNames(isExpanded: true, name: ["sdf","sfsdfsf"])]

    var showIndexPaths = false
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
            let coinImage = UIImageView(image: UIImage(named: "navigation_arrow.png"))
            coinImage.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            coinImage.clipsToBounds = true
        
            coinImage.contentMode = UIViewContentMode.scaleAspectFit
            coinImage.translatesAutoresizingMaskIntoConstraints = false

        let coinLabel = UILabel()
        coinLabel.translatesAutoresizingMaskIntoConstraints = false
        coinLabel.text = "haha"
        
        
//        let myTextField = UITextField()
//        let bottomLine = CALayer()
//        bottomLine.frame = CGRect(x: 0.0, y: myTextField.frame.height - 1, width: myTextField.frame.width, height: 1.0)
//        bottomLine.backgroundColor = UIColor.white.cgColor
//        myTextField.borderStyle = UITextBorderStyle.none
//        myTextField.layer.addSublayer(bottomLine)
        let button = UIButton(type:.system)
        button.setTitle("Edit", for: .normal)
//        button.backgroundColor = ThemeColor().bglColor()
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        button.tag = section
        
        
        
        let sectionView = UIView()
        sectionView.clipsToBounds = true
        sectionView.addSubview(button)
        sectionView.addSubview(coinImage)
        sectionView.addSubview(coinLabel)
        sectionView.backgroundColor = ThemeColor().bglColor()
        button.translatesAutoresizingMaskIntoConstraints = false
//        views.translatesAutoresizingMaskIntoConstraints = false

        

      
        
        sectionView.layer.borderWidth = 1
        
        NSLayoutConstraint(item: button, attribute: .centerY, relatedBy: .equal, toItem: sectionView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
         NSLayoutConstraint(item: coinImage, attribute: .centerY, relatedBy: .equal, toItem: sectionView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: coinLabel, attribute: .centerY, relatedBy: .equal, toItem: sectionView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
        sectionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage]))
        sectionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0(30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinImage]))
        sectionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v1]-10-[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":coinLabel,"v1":coinImage]))
        sectionView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[v0]-10-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":button]))
        
        return sectionView
    }
    
    @objc func handleExpandClose(button:UIButton ){
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in twoDimension[section].name.indices{
            let indexPath = IndexPath(row:row,section:section)
            indexPaths.append(indexPath)
        }
        let isExpanded = twoDimension[section].isExpanded
        twoDimension[section].isExpanded = !isExpanded
        
        
        button.setTitle(isExpanded ? "Edit":"Edit", for: .normal)
        
        if !isExpanded{
            alertTableView.insertRows(at: indexPaths, with: .fade)
        } else{
            alertTableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimension.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimension[section].isExpanded{
            return 0
        }
        return twoDimension[section].name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "editAlertCell", for: indexPath) as! AlertTableViewCell
//        let name = twoDimension[indexPath.section].name[indexPath.row]
        cell.compareLabel.text = twoDimension[indexPath.section].name[indexPath.row]
        
//        cell.textLabel?.text = name
        return cell
    }
    
    func setUpView(){
        view.addSubview(alertTableView)
        
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":alertTableView]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":alertTableView]))
    }
    
    lazy var alertTableView:UITableView = {
       var tableView = UITableView()
        tableView.backgroundColor = ThemeColor().themeColor()
        tableView.register(AlertTableViewCell.self, forCellReuseIdentifier: "editAlertCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
}
