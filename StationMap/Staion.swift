//
//  Staion.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/15.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import Foundation
import ObjectMapper

class Station: Mappable {
    var code: Int?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["station_cd"]
        self.name <- map["station_name"]
        self.longitude <- map["lon"]
        self.latitude <- map["lat"]
    }

}
