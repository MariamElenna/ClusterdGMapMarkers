//
//  ClustringViewModel.swift
//  GMapWithMarker
//
//  Created by Mariam on 8/31/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import Foundation

public class ClustringViewModel {
    
    var latitude : Double!
    var longitude : Double!
    
    
    func generateCoordinates(isCluster: Bool , countryList : CountryModel ,clusterManager : GMUClusterManager ) {
        //clusterManager.clearItems()
        for country in countryList.countries ?? []{
            if country.latitude != 0  && country.longitude != 0 {
                latitude  = country.latitude ?? 0.0
                longitude = country.longitude ?? 0.0
                
                let position = CLLocationCoordinate2D(latitude: latitude , longitude: longitude)
                
                let item = POIItem(position: position, name: country.country  ?? "" )
                clusterManager.add(item)
                
            }
        }
    }
}
