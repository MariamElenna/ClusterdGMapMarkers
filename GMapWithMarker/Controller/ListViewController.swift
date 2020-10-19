//
//  ListViewController.swift
//  GMapWithMarker
//
//  Created by Mariam on 2/17/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {
    
    var pageNumber = 0
    var lastPage = 4
    var list : [RepoModel] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let service = ListService.init(delegate: self)
        service.getUserList(inPageNumber: pageNumber, perPage: 15)
        tableView.reloadData()
        
    }
}

extension ListViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ListTableViewCell
        cell.nameLable.text = list[indexPath.row].fullName
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = list.count - 1
        if indexPath.row == lastItem{
            if pageNumber  < lastPage {
                pageNumber+=1
                let service = ListService.init(delegate: self)
                service.getUserList(inPageNumber: pageNumber, perPage: 15)
                let spinner = UIActivityIndicatorView(style: .gray)
                spinner.startAnimating()
                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
                
                self.tableView.tableFooterView = spinner
                self.tableView.tableFooterView?.isHidden = false
            }else{
                self.tableView.tableFooterView?.isHidden = true
            }
            
        }
    }
    
}


extension ListViewController : WebServiceDelegate{
    func didreceiveDate(data: Codable) {
        if let model = data as? [RepoModel]{
            print(model)
            list.append(contentsOf: model)
            tableView.reloadData()
            
        }
    }
}
