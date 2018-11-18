//
//  LineTableViewController.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/18.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import UIKit

protocol LineTableDelegate {
    func selectedLine(lineCode: Int)
}

class LineTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var delegate: LineTableDelegate?
    var lines: [Line]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lines?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "LineCell", for: indexPath)
        
        guard let lines = self.lines else {
            cell.textLabel!.text = "エラーが発生しました"
            return cell
        }
        
        cell.textLabel!.text = lines[indexPath.row].name ?? ""
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let lines = self.lines else {
            return
        }
        
        // 通知
        self.delegate?.selectedLine(line: lines[indexPath.row].code!)
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
