//
//  MarkerViewModel.swift
//  GMapWithMarker
//
//  Created by Mariam on 8/30/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import Foundation



public class MarkerViewModel {
    
    var cityName : String!
    
    
    func generateCustomMarker(cityName : String) -> UIImage {
        let markerView = UIView()
        let markerViewLable = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        markerViewLable.font = markerViewLable.font.withSize(10.0)
        
        markerViewLable.text = cityName
        markerViewLable.textAlignment = .center
        markerView.backgroundColor = .orange
        markerView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        markerView.layer.cornerRadius = 25
        markerView.clipsToBounds = true
        markerView.addSubview(markerViewLable)
        // convert UiView to UiImage to set it to the marker icon
        let markerIcon = markerView.asImage()
        
        return markerIcon
    }
    
    
    func parseCountriesJsonFile() -> CountryModel{
        let path = Bundle.main.path(forResource: "country-codes-lat-long-alpha3", ofType: "json")
        let jsonData = try! String(contentsOfFile: path!).data(using: .utf8)!
        var countryList : CountryModel!
        countryList = try! JSONDecoder().decode(CountryModel.self, from: jsonData)
        
        return countryList
    }
    
}
