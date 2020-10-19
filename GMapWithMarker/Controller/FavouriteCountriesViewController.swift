//
//  FavouriteCountriesViewController.swift
//  GMapWithMarker
//
//  Created by Mariam on 2/25/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import UIKit
import RealmSwift

class FavouriteCountriesViewController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDataLable: UILabel!
    
    let realm = try! Realm()
    var favouriteCountries : Results<FavouriteCountries>?
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return favouriteCountries?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell")
        cell?.textLabel?.text = favouriteCountries?[indexPath.row].name
        
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if favouriteCountries?.count == 0 || favouriteCountries == nil{
            tableView.isHidden = true
        }else{
            favouriteCountries = realm.objects(FavouriteCountries.self)
        }
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if favouriteCountries?.count != 0{
            noDataLable.isHidden = true
            tableView.isHidden = false
        }
        
        tableView.reloadData()
    }

}

