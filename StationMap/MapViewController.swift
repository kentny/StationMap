//
//  MapViewController.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/16.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import UIKit
import MapKit

class StationPointAnnotation: MKPointAnnotation {
    var isSelected = false
}

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var line: Line!
    var selectedStation: Station!
//    var stationGroup: StationGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self

        let location = CLLocationCoordinate2DMake(self.selectedStation.latitude!,
                                                  self.selectedStation.longitude!)
        
        self.mapView.setCenter(location, animated: true)
        
        // 表示タイプを航空写真と地図のハイブリッドに設定
        mapView.mapType = .standard

        if let stations = self.line.stations {
            self.showAnnotations(stations: stations)
        }
        
//        StationRepository.stationGroup(stationCode: self.selectedStation.code!, callback: { stationGroup in
//            print(stationGroup)
//            self.stationGroup = stationGroup
//        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(#function)
    }
    
    // 指定された駅全てにピンを打つ
    func showAnnotations(stations: [Station]) {
        // 全てのピンを削除
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        for station in stations {
            let isSelected = (station.code! == self.selectedStation.code!)
            
            let location = CLLocationCoordinate2DMake(station.latitude!,
                                                      station.longitude!)
            
            if isSelected {
                // 縮尺を設定
                var region = mapView.region
                region.center = location
                region.span.latitudeDelta = 0.02
                region.span.longitudeDelta = 0.02
                
                self.mapView.setRegion(region, animated: true)
                
            }
            self.markStation(name: station.name, location: location, isSelected: isSelected)
            
        }

    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            return
        }
        
        if id == "ToLine" {
            guard let lines = sender as? [Line] else {
                return
            }
            let vc = segue.destination as? LineViewController
            vc?.lines = lines
            
        }
    }
    
    func markStation(name: String?, location: CLLocationCoordinate2D, isSelected: Bool) {
        let annotation = StationPointAnnotation()
        
        annotation.coordinate = location
        annotation.isSelected = isSelected
        
        if name != nil {
            annotation.title = name
        }
        
        self.mapView.addAnnotation(annotation)
        if isSelected {
            self.mapView.selectAnnotation(annotation, animated: true)
        }
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        
        
    }
    

    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard let stationAnnotation = annotation as? StationPointAnnotation else {
            print("Unexpected annotation cast error")
            return nil
        }
        
        let pinView = MKPinAnnotationView(annotation: stationAnnotation, reuseIdentifier: nil)
        
        // アニメーションON
        pinView.animatesDrop = true
        
        // 吹き出しON
        pinView.canShowCallout = true
        
        // ピン色設定
        if stationAnnotation.isSelected {
            pinView.pinTintColor = UIColor.red
        } else {
            pinView.pinTintColor = UIColor.blue
        }
        
        
        //左ボタンをアノテーションビューに追加する。
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 40)
        button.setTitle("全路線図", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: UIControl.Event.touchUpInside)
        pinView.leftCalloutAccessoryView = button

        return pinView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print(#function)
        
        guard let pinView = view as? MKPinAnnotationView else {
            return
        }
        
        pinView.pinTintColor = .red
//        for annotation in mapView.selectedAnnotations {
//            mapView.deselectAnnotation(annotation, animated: true)
//        }
//
//        if let annotation = view.annotation {
//            mapView.selectAnnotation(annotation, animated: true)
//        }
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print(#function)
        guard let pinView = view as? MKPinAnnotationView else {
            return
        }
        
        pinView.pinTintColor = .blue
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        StationRepository.stationGroup(stationCode: self.selectedStation.code!, callback: { stationGroup in
            
            guard let groups = stationGroup?.groups else {
                return
            }
            
            // StationGroup を Lineの配列に変換
            var lines = [Line]()
            for group in groups {
                let line = Line()
                line.name = group.lineName
                line.code = group.lineCode
                
                lines.append(line)
            }
            
            
            self.performSegue(withIdentifier: "ToLine", sender: lines)
        })
    }

}
