//
//  LineViewController.swift
//  StationMap
//
//  Created by Kentaro Terasaki on 2018/11/18.
//  Copyright © 2018年 Kentaro Terasaki. All rights reserved.
//

import UIKit

class LineViewController: UIViewController, LineTableDelegate {

    @IBOutlet weak var containerView: UIView!
    var lines: [Line]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier else {
            return
        }
        
        if id == "ToLineTable" {
            let vc = segue.destination as? LineTableViewController
            vc?.lines = self.lines
            vc?.delegate = self
        }
    }
    
    func selectedLine(lineCode: Int) {
        
        StationRepository.line(lineCode: lineCode, callback: { line in
            
            if let navigationController = self.presentingViewController as? UINavigationController {
                if let mapVC = navigationController.topViewController as? MapViewController, let line = line {
                    mapVC.showAnnotations(line: line)
                }
            }
            self.dismiss(animated: true, completion: nil)

        })
        
    }
    
    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        
        self.dismiss(animated: true, completion: nil)
    }
}
