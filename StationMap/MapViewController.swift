//
//  MapViewController.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/16.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var station: Station!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self

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
        annotation.title = self.station.name
        
        self.mapView.addAnnotation(annotation)
        self.mapView.selectAnnotation(annotation, animated: true)
        self.mapView.showAnnotations(self.mapView.annotations, animated: true)

        
        StationRepository.stationGroup(stationCode: self.station.code!, callback: { stationGroup in
            print(stationGroup)
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
        
        // アニメーションON
        pinView.animatesDrop = true
        
        // 吹き出しON
        pinView.canShowCallout = true
        
        let iconView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 40, height: 40)))
        iconView.backgroundColor = UIColor.black
        let iconImageView = UIImageView(image: UIImage(named: "train.jpeg"))
        iconImageView.frame = CGRect(origin: .zero, size: CGSize(width: 40, height: 40))
        iconView.addSubview(iconImageView)
        
        // 左側に配置
        pinView.leftCalloutAccessoryView = iconView
        
        return pinView
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
