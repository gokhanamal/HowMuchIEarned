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

    private let hourlyWage = 10;
    private let currency = "$";
    private let API_KEY = "a997d4c6a7609fd00ca4f42cfb8304d5"
    private var timer: Timer?
    private let statusItem = NSStatusBar.system.statusItem(withLength: -1);
  
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setTimer()
        calculateTotalAmount()
        constructMenu()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        timer = nil
    }
    
    
    private func setTimer() {
        timer = Timer.scheduledTimer(timeInterval: 60.0, target: self, selector: #selector(calculateTotalAmount), userInfo: nil, repeats: true)
    }
    
    func constructMenu() {
        let menu = NSMenu()
        menu.addItem(NSMenuItem(title: "Prefrences", action: #selector(preferences), keyEquivalent: "P"))
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(quit), keyEquivalent: "Q"))
        statusItem.menu = menu
    }
    
    @objc func quit(_ sender: Any?){
        NSApplication.shared.terminate(sender)
    }
    
    @objc func preferences(_ sender: Any?){
        let viewController = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "Pref") as! NSViewController
    }

    
    @objc func calculateTotalAmount(){
        let url = URL(string: "https://desktime.com/api/v2/json/employee/basic?apiKey="+API_KEY)!
        let task = URLSession.shared.dataTask(with: url) { data,response,error in
            guard let data = data else { return }
            let decoder = JSONDecoder()
            do {
                let json = try decoder.decode(DesktimeResponse.self, from:  data)
                let totalWage = (json.desktimeTime/60.0) * Float(self.hourlyWage) ;
                let formated = String(format: "%.2f", totalWage)
                print(formated)
                DispatchQueue.main.async {
                    if let button = self.statusItem.button {
                        button.title = self.currency + formated;
                    }
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    struct DesktimeResponse: Codable {
        let id: Int
        let email: String
        let name: String
        let desktimeTime: Float
        let profileUrl: String
    }
}

