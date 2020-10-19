//
//  ViewController.swift
//  GMapWithMarker
//
//  Created by Mariam on 2/17/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import UIKit
import GoogleMaps
import GoogleMapsUtils
import RealmSwift



class POIItem: NSObject, GMUClusterItem {
    var position: CLLocationCoordinate2D
    var name: String!
    
    init(position: CLLocationCoordinate2D, name: String) {
        self.position = position
        self.name = name
    }
}

class GMapViewController: UIViewController , GMSMapViewDelegate , GMUClusterManagerDelegate{
    
    var mapView : GMSMapView!
    var clusterManager : GMUClusterManager!
    var countryList : CountryModel!
    
    var latitude : Double!
    var longitude : Double!
    
    
    var markerViewModel = MarkerViewModel()
    var clustringViewModel = ClustringViewModel()
   
    
    let realm = try! Realm()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countryList = markerViewModel.parseCountriesJsonFile()
        
        mapView = GMSMapView(frame: view.frame)
        mapView.camera = GMSCameraPosition.camera(withLatitude: countryList.countries?[0].latitude ?? 1.0, longitude: countryList.countries?[0].longitude ?? 1.0, zoom: 3.0)
        mapView.mapType = .normal
        mapView.delegate = self
        view.addSubview(mapView)
        
        
        
        let iconGenerator = GMUDefaultClusterIconGenerator()
        let algorithm = GMUNonHierarchicalDistanceBasedAlgorithm()
        let renderer = GMUDefaultClusterRenderer(mapView: mapView, clusterIconGenerator: iconGenerator)
        clusterManager = GMUClusterManager(map: mapView, algorithm: algorithm, renderer: renderer)
        //generateCoordinates(isCluster: true)
        clustringViewModel.generateCoordinates(isCluster: true, countryList: countryList ,clusterManager : clusterManager)
        
        // Call cluster() after items have been added to perform the clustering and rendering on map.
        clusterManager.cluster()
        clusterManager.setDelegate(self, mapDelegate: self)
        
    }
    
    private func clusterManager(clusterManager: GMUClusterManager, didTapCluster cluster: GMUCluster) {
        let newCamera = GMSCameraPosition.camera(withTarget: cluster.position,
                                                 zoom: mapView.camera.zoom + 1)
        let update = GMSCameraUpdate.setCamera(newCamera)
        mapView.moveCamera(update)
    }
    
    //Show the marker title while tapping
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        let item : POIItem = marker.userData as! POIItem
        marker.icon = markerViewModel.generateCustomMarker(cityName: item.name)
        mapView.selectedMarker = marker
        //favouriteCountries.append(item)
        let m = FavouriteCountries()
        m.name = item.name
        m.longitude = String(item.position.longitude)
        m.latitude = String(item.position.latitude)
        
        try! realm.write {
            realm.add(m)
        }
        
        alertWithMessage("\(item.name ?? "country") Added to your Favourite")
        return true
    }
}
