//
//  SearchNewsController.swift
//  BGL-MediaApp
//
//  Created by Bruce Feng on 6/6/18.
//  Copyright © 2018 Xuyang Zheng. All rights reserved.
//

import UIKit

class SearchNewsController: UIViewController,UISearchBarDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        // Do any additional setup after loading the view.
    }

    func setupView(){
        view.backgroundColor = ThemeColor().themeColor()
        view.addSubview(searchBar)
//        view.addSubview(searchResult)
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchBar]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchBar]))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchBar,"v1":searchResult]))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[v0]-[v1]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":searchBar,"v1":searchResult]))
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        if searchBar.text == nil || searchBar.text == ""{
//            isSearching = false
//            view.endEditing(true)
//            searchResult.reloadData()
//        } else{
//            isSearching = true
//            filterExchanges = allExchanges.filter{ name in return name.lowercased().contains(searchBar.text!.lowercased())}
//            searchResult.reloadData()
//        }
    }
    
    lazy var searchBar:UISearchBar={
        var searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        searchBar.barTintColor = ThemeColor().walletCellcolor()
        searchBar.tintColor = ThemeColor().themeColor()
        searchBar.backgroundColor = ThemeColor().fallColor()
        return searchBar
    }()
}
