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
    var groupCode: Int?
    var name: String?
    var latitude: Double?
    var longitude: Double?
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.code <- map["station_cd"]
        self.groupCode <- map["station_g_cd"]
        self.name <- map["station_name"]
        self.longitude <- map["lon"]
        self.latitude <- map["lat"]
    }

}
