//
//  CountryModel.swift
//  GMapWithMarker
//
//  Created by Mariam on 2/19/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import Foundation
import RealmSwift



struct CountryModel : Codable {
    
    let countries : [Country]?
    
    enum CodingKeys: String, CodingKey {
        case countries = "ref_country_codes"
    }
}

class Country : Codable {

    let alpha2 : String?
    let alpha3 : String?
    let country : String?
    let latitude : Double?
    let longitude : Double?
    let numeric : Int?

    enum CodingKeys: String, CodingKey {
        case alpha2 = "alpha2"
        case alpha3 = "alpha3"
        case country = "country"
        case latitude = "latitude"
        case longitude = "longitude"
        case numeric = "numeric"
    }
    
}


class FavouriteCountries: Object {
    @objc dynamic var name = ""
    @objc dynamic var latitude = ""
    @objc dynamic var longitude = ""
    
}
