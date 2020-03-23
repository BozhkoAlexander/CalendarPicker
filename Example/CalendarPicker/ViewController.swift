//
//  ViewController.swift
//  CalendarPicker
//
//  Created by BozhkoAlexander on 03/23/2020.
//  Copyright (c) 2020 BozhkoAlexander. All rights reserved.
//

import UIKit
import CalendarPicker

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func chooseDatePressed(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            let vc = CalendarPickerController()
            present(vc, animated: true)
        }
    }

}

