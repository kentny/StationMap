//
//  MapViewController.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/16.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var station: Station!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let location = CLLocationCoordinate2DMake(self.station.latitude!,
                                                  self.station.longitude!)
        
        self.mapView.setCenter(location, animated: true)
        
        // 縮尺を設定
        var region = mapView.region
        region.center = location
        region.span.latitudeDelta = 0.02
        region.span.longitudeDelta = 0.02
        
        self.mapView.setRegion(region, animated: true)
        
        // 表示タイプを航空写真と地図のハイブリッドに設定
        mapView.mapType = .standard

        // 全てのピンを削除
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        self.mapView.addAnnotation(annotation)
        self.mapView.selectAnnotation(annotation, animated: true)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
