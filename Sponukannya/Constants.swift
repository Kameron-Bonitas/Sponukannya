//
//  Constants.swift
//  Sponukannya
//
//  Created by Ben on 19.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import Foundation
import UIKit


enum ListConctollerCellMesurements {
    
     static let cellHeight: CGFloat = 70
     static let minimumSwipeCellWidth: CGFloat = 70.0
   }

enum TimeIntervals {
 static let timeIntervalForEndDate: Double = 3600
}

enum NotificationReminder {
       static var title = NSLocalizedString("A little reminder:", comment: "A little reminder:")
       static var body = ""
   }
   



enum Color {
    static let swipeCellBackgroundColorForDefault = UIColor (named: "swipeCellBackgroundColorForDefault")
//        .init(red: 240/255, green: 214/255, blue: 226/255, alpha: 1)
    static let swipeCellBackGroundColorForDestructive = UIColor (named: "swipeCellBackGroundColorForDestructive ")
//        .init(red: 242/255, green: 93/255, blue: 97/255, alpha: 1)
    static let separatorCustomColor = UIColor (named: "separatorCustomColor")
//        .init(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
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
    
   
    

