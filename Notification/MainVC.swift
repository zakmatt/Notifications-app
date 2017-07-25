//
//  ViewController.swift
//  Notification
//
//  Created by Admin on 25/07/2017.
//  Copyright © 2017 Mattowy. All rights reserved.
//

import UIKit
import UserNotifications

class MainVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        requestAccess()
    }
}

extension MainVC {
    func requestAccess() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { (granted, error) in
            
            if granted {
                print("Notification access granted")
            } else {
                print(error?.localizedDescription)
            }
            
        })
    }
    
    @IBAction func notificationButtonTapped(sender: UIButton) {
        scheduleNotification(inSeconds: 5, completion: { success in
            if success {
                print("Successfully scheduled notification")
            } else {
                print("A problem was encountered while scheduling notification")
            }
        })
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        let notify = UNMutableNotificationContent()
        
        notify.title = "New notification!"
        notify.subtitle = "Super subtitle notification"
        notify.body = "This is the super body of popped notification!"
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: "myNotification", content: notify, trigger: notificationTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
            if error != nil {
                print(error)
                completion(false)
            } else {
                completion(true)
            }
        })
    }
}

