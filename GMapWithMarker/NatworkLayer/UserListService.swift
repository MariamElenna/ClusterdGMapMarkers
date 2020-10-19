//
//  UserListService.swift
//  GMapWithMarker
//
//  Created by Mariam on 2/17/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import Foundation
import Alamofire



protocol WebServiceDelegate:class {
    func didreceiveDate(data: Codable)
}

class ListService {
    weak var delegate: WebServiceDelegate?
    
    init(delegate: WebServiceDelegate) {
        self.delegate = delegate
    }
    func getUserList(inPageNumber : Int , perPage : Int) {
        let url = NetworkConstants.baseUrl + "page=\(inPageNumber)&amp;per_page=\(perPage)"
        
        Alamofire.request(url, method: .get, parameters: [:], headers: [:]).responseJSON{ (response) in
        switch response.result {
        case .success(let value):
            print(value)
            let data = try! JSONDecoder().decode([RepoModel].self, from: response.data!)
            self.delegate?.didreceiveDate(data: data)
            break
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
