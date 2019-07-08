//
//  AppDelegate.swift
//  HowMuchIEarned
//
//  Created by Gokhan Namal on 2.07.2019.
//  Copyright © 2019 Gokhan Namal. All rights reserved.
//
import Cocoa
import Alamofire

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {


    let statusItem = NSStatusBar.system.statusItem(withLength: -1);
    public let hourlyWage = 0;
    public let currency = "$";
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        self.calculatePrice();
        self.constructMenu();
        _ = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(calculatePrice), userInfo: nil, repeats: true)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    
    @objc func calculatePrice(){
        // Insert code here to initialize your application
        let url = "https://desktime.com/api/v2/json/employee/basic?apiKey=1f01c6d47857f57e9962b9129bdbf44b"
        Alamofire.request(url).responseJSON { response in
            
            if let json = response.result.value {
                let response = json as! NSDictionary
                let desktimeTime = response.object(forKey: "desktimeTime")!
                let totalWage = desktimeTime as! Float/600;
                let formated = String(format: "%.2f", totalWage)
                if let button = self.statusItem.button {
                    button.title = self.currency + formated;
                }
            }
        }
    }
    
    
    @objc func quit(_ sender: Any?){
        NSApplication.shared.terminate(sender)
    }
    
    @objc func preferences(_ sender: Any?){
        var myWindowController = NSStoryboard(name: "Pref", bundle: nil).instantiateController(withIdentifier: "ViewController") as! NSViewController
        myWindowController.showWindow(self)
    
    }
    
    func constructMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Prefrences", action: #selector(preferences), keyEquivalent: "P"))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "Q"))
        statusItem.menu = menu
    }
    
}

