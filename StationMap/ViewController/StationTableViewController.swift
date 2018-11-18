//
//  StationViewController.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/15.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import UIKit

class StationViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let yamanoteLineCode: Int = 11302

    @IBOutlet weak var tableView: UITableView!
    
    var line: Line?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        StationRepository.line(lineCode: self.yamanoteLineCode,
                                   callback: { line in
                                    
                                    self.line = line
                                    self.tableView.reloadData()
                                    
        })
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.line?.stations?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "StationCell", for: indexPath)
        
        guard let stations = self.line?.stations else {
            return cell
        }
        
        cell.textLabel!.text = stations[indexPath.row].name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let stations = self.line?.stations else {
            return
        }
        
        let station = stations[indexPath.row]
        
        // マップ画面遷移
        self.performSegue(withIdentifier: "ToMap", sender: station)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            return
        }
        
        if id == "ToMap" {
            let mapVC = segue.destination as? MapViewController
            mapVC?.line = self.line!
            mapVC?.selectedStation = sender as? Station
        }
    }

}

