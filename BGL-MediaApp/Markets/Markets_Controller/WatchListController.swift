//
//  WatchListController.swift
//  news app for blockchain
//
//  Created by Bruce Feng on 4/6/18.
//  Copyright © 2018 Sheng Li. All rights reserved.
//

import UIKit
import RealmSwift

class WatchListController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource, SortPickerViewDelegate {
    let watchList = WatchListView()
    
    
    var marketSortPickerView = MarketSortPickerView()
    var sortitems = [String]()
    var sortdate = ["1W","1D","1H"]
    let pickerview = UIPickerView()
    let general = generalDetail()
    var color = ThemeColor()
    
    var coinSymbolInWatchListRealm = try! Realm().objects(CoinsInWatchListRealm.self)
    var tickerDataRealmObjects = try! Realm().objects(TickerDataRealm.self)
    
    var filterDateSelection: Int?
    
    var sortOption: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        getCoinWatchList()
        watchList.marketSortPickerView.sortPickerViewDelegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(reloadDataAfterUpdateWatchList), name: NSNotification.Name(rawValue: "updateWatchInWatchList"), object: nil)
        // Do any additional setup after loading the view.
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return watchList.sortdate.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SortDate", for: indexPath) as! MarketFilterCollectionView
        cell.label.text = watchList.sortdate[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width:watchList.sortDate.frame.width / 3, height: watchList.sortDate.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //收藏列表
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coinSymbolInWatchListRealm.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! MarketsCoinTableViewCell
        cell.backgroundColor = color.themeColor()
        
        let object = tickerDataRealmObjects[indexPath.row]
        
        cell.priceChange = [object.percent_change_7d, object.percent_change_24h, object.percent_change_1h][filterDateSelection ?? 0]
        cell.object = object
        
        return cell
    }
    
    func getCoinWatchList() {
        let allCoinsSymbol = coinSymbolInWatchListRealm.map {$0.symbol}
        tickerDataRealmObjects = try! Realm().objects(TickerDataRealm.self).filter("symbol in %@", Array(allCoinsSymbol))
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == watchList.sortDate {
            filterDateSelection = indexPath.row
            watchList.coinList.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == watchList.coinList{
            let cell = watchList.coinList.cellForRow(at: indexPath) as! MarketsCoinTableViewCell
            let global = GloabalController()
            global.coinDetail.coinName = cell.coinLabel.text!
            navigationController?.pushViewController(global, animated: true)
        }
    }
    
    func reloadDataSortedByName() {
        tickerDataRealmObjects = tickerDataRealmObjects.sorted(byKeyPath: "symbol", ascending: true)
        watchList.coinList.reloadData()
    }
    
    func reloadDataSortedByPrice() {
        tickerDataRealmObjects = tickerDataRealmObjects.sorted(byKeyPath: "price", ascending: false)
        watchList.coinList.reloadData()
    }
    
    @objc func reloadDataAfterUpdateWatchList() {
        getCoinWatchList()
        if let sortOption = sortOption {
            if sortOption == 0 {
                reloadDataSortedByName()
            } else {
                reloadDataSortedByPrice()
            }
        } else {
            watchList.coinList.reloadData()
        }
    }
    
    func setSortOption(option: Int) {
        sortOption = option
    }
    
    func setUpView(){
        view.addSubview(watchList)
//        
//        sortItems.append(textValue(name: "sortByLetter_market"))
//        sortItems.append(textValue(name: "sortByHighestPrice_market"))
//        filterDateitems.append(textValue(name: "filterByWeek_market"))
//        filterDateitems.append(textValue(name: "filterByDay_market"))
//        filterDateitems.append(textValue(name: "filterByHour_market"))
        
        watchList.coinList.backgroundColor = ThemeColor().themeColor()
        watchList.sortDate.delegate = self
        watchList.sortDate.dataSource = self
        watchList.coinList.delegate = self
        watchList.coinList.dataSource = self
        watchList.backgroundColor = ThemeColor().themeColor()
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":watchList]))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":watchList]))
    }
}
