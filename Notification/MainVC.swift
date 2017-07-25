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
    
    func createAttachment(completion: (_ Success: Bool) -> ()) -> UNNotificationAttachment? {
        let myImage = "buy_personality"
        guard let imageURL = Bundle.main.url(forResource: myImage, withExtension: "jpeg") else {
            completion(false)
            return nil
        }
        
        var attachment: UNNotificationAttachment
        attachment = try! UNNotificationAttachment(identifier: NOTIFICATION_IDENTIFIER, url: imageURL, options: .none)
        return attachment
    }
    
    func scheduleNotification(inSeconds: TimeInterval, completion: @escaping (_ Success: Bool) -> ()) {
        
        let notify = UNMutableNotificationContent()
        
        notify.title = "New notification!"
        notify.subtitle = "Super subtitle notification"
        notify.body = "This is the super body of popped notification!"
        
        if let attachment = createAttachment(completion: completion) {
            notify.attachments = [attachment]
        }
        
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: inSeconds, repeats: false)
        
        let request = UNNotificationRequest(identifier: NOTIFICATION_IDENTIFIER, content: notify, trigger: notificationTrigger)
        
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

