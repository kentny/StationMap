//
//  Line.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/16.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import Foundation
import ObjectMapper

class Line: Mappable {
    var code: Int?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    var stations: [Station]?
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["line_cd"]
        self.name <- map["line_name"]
        self.longitude <- map["line_lon"]
        self.latitude <- map["line_lat"]
        self.stations <- map["station_l"]
    }
    
}
