//
//  Group.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/17.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import Foundation
import ObjectMapper

class StationGroup: Mappable {
    var groups: [Group]?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.groups <- map["station_g"]
    }
}

class Group: Mappable {
    var prefCode: Int?
    var lineCode: Int?
    var lineName: String?
    var stationCode: Int?
    var stationName: String?
    
    init() {
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        self.prefCode <- map["pref_cd"]
        self.lineCode <- map["line_cd"]
        self.lineName <- map["line_name"]
        self.stationCode <- map["station_cd"]
        self.stationName <- map["station_name"]
    }
    
}
