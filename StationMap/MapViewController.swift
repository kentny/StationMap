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
    var stationGroup: StationGroup!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self

        let location = CLLocationCoordinate2DMake(self.selectedStation.latitude!,
                                                  self.selectedStation.longitude!)
        
        self.mapView.setCenter(location, animated: true)
        
        // 表示タイプを航空写真と地図のハイブリッドに設定
        mapView.mapType = .standard

        // 全てのピンを削除
        self.mapView.removeAnnotations(self.mapView.annotations)
        
        if let stations = self.line.stations {
            self.showAnnotations(stations: stations)
        }
        
        StationRepository.stationGroup(stationCode: self.selectedStation.code!, callback: { stationGroup in
            print(stationGroup)
            self.stationGroup = stationGroup
        })
    }
    
    // 指定された駅全てにピンを打つ
    func showAnnotations(stations: [Station]) {
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
            let vc = segue.destination as? LineViewController
            vc?.li
            
        }
    }
    
    func markStation(name: String?, location: CLLocationCoordinate2D, isSelected: Bool) {
        let annotation = StationPointAnnotation()
        
        print("isSelected: \(isSelected)")
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
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        button.setTitle("色", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.yellow
        button.event
        button.addTarget(self, action: #selector(buttonEvent(_:)), for: UIControlEvents.touchUpInside)
        pinView.leftCalloutAccessoryView = button

        return pinView
    }

    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    }
    
    func buttonTapped(_ sender: UIButton) {
        StationRepository.stationGroup(stationCode: self.selectedStation.code!, callback: { stationGroup in
            self.stationGroup = stationGroup
            self.performSegue(withIdentifier: "ToLine", sender: stationGroup)
        })
    }
    
    //////////////////////////
    
//    //マップビュー長押し時の呼び出しメソッド
//    @IBAction func pressMap(sender: UILongPressGestureRecognizer) {
//
//        //マップビュー内のタップした位置を取得する。
//        let location:CGPoint = sender.locationInView(testMapView)
//
//        if (sender.state == UIGestureRecognizerState.Ended){
//
//            //タップした位置を緯度、経度の座標に変換する。
//            let mapPoint:CLLocationCoordinate2D = testMapView.convertPoint(location, toCoordinateFromView: testMapView)
//
//            //ピンを作成してマップビューに追加する。
//            let annotation = MKPointAnnotation()
//            annotation.coordinate = CLLocationCoordinate2DMake(mapPoint.latitude, mapPoint.longitude)
//            testMapView.addAnnotation(annotation)
//        }
//    }
    
    
    
//    //アノテーションビューを返すメソッド
//    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
//
//        //アノテーションビューを作成する。
//        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier:nil)
//
//        //吹き出しに表示するスタックビューを生成する。
//        let stackView = UIStackView()
//        stackView.axis = UILayoutConstraintAxis.Vertical
//        stackView.alignment = UIStackViewAlignment.Leading
//
//        //吹き出しのタイトルに店名を設定する。
//        if let pointAnnotation = annotation as? MKPointAnnotation {
//            pointAnnotation.title = place.name
//        }
//
//        //スタックビューに住所を追加する。
//                                if let text = place.formattedAddress {
//                                    let testLabel2:UILabel = UILabel()
//                                    testLabel2.frame = CGRectMake(0,0,200,0)
//                                    testLabel2.sizeToFit()
//                                    testLabel2.text = text
//                                    stackView.addArrangedSubview(testLabel2)
//                                }
//
//                                //スタックビューに電話番号を追加する。
//                                if let text = place.phoneNumber {
//                                    let testLabel:UILabel = UILabel()
//                                    testLabel.frame = CGRectMake(0,0,200,0)
//                                    testLabel.text = text
//                                    stackView.addArrangedSubview(testLabel)
//                                }
//
//
//                                //スタックビューにサイトURLを追加する。
//                                if let text = place.website {
//                                    let testLabel3:UILabel = UILabel()
//                                    testLabel3.frame = CGRectMake(0,0,200,0)
//                                    testLabel3.sizeToFit()
//                                    testLabel3.text = String(text)
//                                    stackView.addArrangedSubview(testLabel3)
//                                }
//
//                                //スタックビューにボタンを追加する。
//                                let button = UIButton()
//                                button.frame = CGRectMake(0,0,200,50)
//                                button.backgroundColor = UIColor.blueColor()
//                                button.setTitleColor(UIColor.whiteColor(), forState:.Normal)
//                                button.setTitle("詳細を見る", forState:.Normal)
//                                stackView.addArrangedSubview(button)
//
//                            } else {
//                                print("詳細情報を取得できませんでした \(placeID)")
//                            }
//                        })
//
//                        //ピンの吹き出しにスタックビューを設定する。
//                        pinView.detailCalloutAccessoryView = stackView
//
//                        //吹き出しの表示をONにする。
//                        pinView.canShowCallout = true
//
//                        //ピンの色を黄色にする。
//                        pinView.pinTintColor = UIColor.blueColor()
//                        break
//                    }
//                } catch {
//                    print("エラー")
//                }
//            }
//        }).resume()
//
//        return pinView
//    }

}
