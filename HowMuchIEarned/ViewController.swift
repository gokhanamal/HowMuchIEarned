//
//  ViewController.swift
//  HowMuchIEarned
//
//  Created by Gokhan Namal on 2.07.2019.
//  Copyright © 2019 Gokhan Namal. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    let appdDelegate = NSApplication.shared.delegate as! AppDelegate
    @IBAction func onPressSave(_ sender: Any) {
    }

    @IBOutlet weak var APIKeyInput: NSTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(appdDelegate.hourlyWage)
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

