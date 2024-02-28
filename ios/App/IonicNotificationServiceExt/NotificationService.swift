//
//  NotificationService.swift
//  IonicNotificationServiceExt
//
//  Created by Logeshwar M on 14/02/24.
//

import UserNotifications
import REIOSSDK

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION",
              title: "Accept", options: .foreground)
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION",
              title: "Decline", options: .destructive)
        
        let meetingInviteCategory =
              UNNotificationCategory(identifier: "MEETING_INVITATION1",
              actions: [acceptAction, declineAction],
              intentIdentifiers: [],
              hiddenPreviewsBodyPlaceholder: "",
              options: .customDismissAction)
        
        var categorySet: Set<UNNotificationCategory> = Set<UNNotificationCategory>();
        categorySet.insert(meetingInviteCategory)
        
        REiosHandler.presentServiceExtension(request: request) { content in
            contentHandler(content)
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
