//
//  NotificationViewController.swift
//  IonicNotificationContentExt
//
//  Created by Logeshwar M on 14/02/24.
//

import UIKit
import UserNotifications
import UserNotificationsUI
import REIOSSDK

class NotificationViewController: UIViewController, UNNotificationContentExtension {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        
        let dynamicLink = [ "applinks": "visionbanknative1.page.link", "storeId": "1289654399", "appBundleId": "com.resulticks.visionbank" ]
        REiosHandler.presnetContentExtension(vc: self, notification: notification, deeplinkData: dynamicLink) { height in
        }
        
        
    }


}
