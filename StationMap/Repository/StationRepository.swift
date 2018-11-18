//
//  StationRepository.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/15.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import Foundation
import ObjectMapper

class StationRepository: NSObject {
    
    class func line(lineCode: Int, callback: ((Line?) -> Void)? ) {
        let url = URL(string: "http://www.ekidata.jp/api/l/\(lineCode).json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {  // メインスレッドに渡す
                if error == nil, let data = data, let _ = response as? HTTPURLResponse {
                    
                    // 応答データをパースしてJSONに整形する
                    let result = String(data: data, encoding: String.Encoding.utf8) ?? "NO DATA"
                    let json = String(result.split(separator: "\n")[1].split(separator: "=")[1])
                    let line: Line? = Mapper<Line>().map(JSONString: json)
                    
                    // 駅一覧を返す
                    callback?(line)
                } else {
                    callback?(nil)
                }
            }
        }.resume()
        
    }
    
    class func stationGroup(stationCode: Int, callback: ((StationGroup?) -> Void)? ) {
        let url = URL(string: "http://www.ekidata.jp/api/g/\(stationCode).json")
        let request = URLRequest(url: url!)
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {  // メインスレッドに渡す
                if error == nil, let data = data, let _ = response as? HTTPURLResponse {
                    
                    // 応答データをパースしてJSONに整形する
                    let result = String(data: data, encoding: String.Encoding.utf8) ?? "NO DATA"
                    let json = String(result.split(separator: "\n")[1].split(separator: "=")[1])
                    let stationGroup: StationGroup? = Mapper<StationGroup>().map(JSONString: json)
                    
                    // 駅グループ一覧を返す
                    callback?(stationGroup)
                } else {
                    callback?(nil)
                }
            }
        }.resume()
        
    }

}
