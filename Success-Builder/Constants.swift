//
//  Constants.swift
//  Sponukannya
//
//  Created by Ben on 19.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import Foundation
import UIKit



enum TimeIntervals {
 static let timeIntervalForEndDate: Double = 3600
}

enum NotificationReminder {
       static var title = NSLocalizedString("A little reminder:", comment: "A little reminder:")
       static var body = ""
   }


enum SettingsAlert {
    static let title = NSLocalizedString("We need your permission", comment: "We need your permission")
    static let message = NSLocalizedString("Go to settings", comment: "Go to settings")
    static let settingActionTitle = NSLocalizedString("Settings", comment: "Settings")
    static let cancelActionTitle = NSLocalizedString("Cancel", comment: "Cancel")
}
    
    enum SettingsAlertCalendar {
        static let title = NSLocalizedString("We need your permission to access your calendar", comment: "We need your permission to access your calendar")
        static let message = NSLocalizedString("Go to settings", comment: "Go to settings")
        static let settingActionTitle = NSLocalizedString("Settings", comment: "Settings")
        static let cancelActionTitle = NSLocalizedString("Cancel", comment: "Cancel")
    }

    enum SettingsAlertNotifications {
        static let title = NSLocalizedString("We need your permission to send you notifications", comment: "We need your permission to send you notifications")
        static let message = NSLocalizedString("Go to settings", comment: "Go to settings")
        static let settingActionTitle = NSLocalizedString("Settings", comment: "Settings")
        static let cancelActionTitle = NSLocalizedString("Cancel", comment: "Cancel")
    }
    
   
    

