//
//  ViewController.swift
//  FilmMap
//
//  Created by Abhinav Tirath on 10/26/19.
//  Copyright © 2019 Abhinav Tirath. All rights reserved.
//

import UIKit
import ArcGIS

class ViewController: UIViewController, AGSGeoViewTouchDelegate, AGSCalloutDelegate {

    @IBOutlet weak var mapView: AGSMapView!
    
    // the query is retained internally by the SDK so use a weak reference
    private weak var activeSelectionQuery: AGSCancelable?
    private var featureLayer: AGSFeatureLayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupMap()
        
        setupLocationDisplay()
    }

    private func setupMap() {
        mapView.map = AGSMap(basemapType: .topographicVector, latitude: 84.3963, longitude: 33.7756, levelOfDetail: 7)
        
        let featureServiceURL = URL(string: "https://services6.arcgis.com/gQNyhIUYjv4JueFV/arcgis/rest/services/map_database/FeatureServer/0")!
        let trailheadsTable = AGSServiceFeatureTable(url: featureServiceURL)

        let featureLayer = AGSFeatureLayer(featureTable: trailheadsTable)
        self.featureLayer = featureLayer
        
        mapView.map!.operationalLayers.add(featureLayer)
        
        //register as the map view's touch delegate
        //in order to get tap notifications
        self.mapView.touchDelegate = self
    }

    
    //MARK: Show user location
    
    func setupLocationDisplay() {
        mapView.locationDisplay.autoPanMode = AGSLocationDisplayAutoPanMode.compassNavigation
        mapView.locationDisplay.start { [weak self] (error:Error?) -> Void in
        if let error = error {
                self?.showAlert(withStatus: error.localizedDescription)
            }
        }
    }
    
    private func showAlert(withStatus: String) {
        let alertController = UIAlertController(title: "Alert", message:
            withStatus, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default,handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - AGSGeoViewTouchDelegate
    
    func geoView(_ geoView: AGSGeoView, didTapAtScreenPoint screenPoint: CGPoint, mapPoint: AGSPoint) {
        //show progress hud for identify
        
        //identify features at tapped location
        self.mapView.identifyLayer(self.featureLayer!, screenPoint: screenPoint, tolerance: 12, returnPopupsOnly: false) { [weak self] (result) in
            //hide progress hud
            
            if let feature = result.geoElements.first as? AGSFeature {
                //select the first feature
                print(feature.attributes)
                let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "PopoverViewController") as! PopoverViewController
                vc.modalPresentationStyle = .popover
                vc.popoverPresentationController?.sourceView = self?.view
                
                let dict = feature.attributes
                vc.movieTitle = dict["movie"] as! String
                vc.sceneTitle = dict["scene_name"] as! String
                vc.sceneDescription = dict["scene_description"] as! String
                if !(dict["clip_url"] is NSNull) {
                    vc.imageLink = dict["clip_url"] as! String
                }
                if !(dict["purchase_url"] is NSNull) {
                    vc.purchaseLink = dict["purchase_url"] as! String
                }
                if !(dict["video_url"] is NSNull) {
                    vc.videoLink = dict["video_url"] as! String
                }
                
                self?.present(vc, animated: true, completion:nil)
            }
        }
    }
}

