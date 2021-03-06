//
//  AppDelegate.swift
//  Sponukannya
//
//  Created by Ben on 10.02.2020.
//  Copyright © 2020 Ben. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate  {

     var hasAlreadyLaunched :Bool!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//printFonts()
        
        //  Asking for user authorisation
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { (granted, error) in
//print("granted: (\(granted)")
        }
        UNUserNotificationCenter.current().delegate = self
        // Prompt Screen
        hasAlreadyLaunched = UserDefaults.standard.bool(forKey: "hasAlreadyLaunched")
        //check first launched
        if (hasAlreadyLaunched)
        {
           hasAlreadyLaunched = true
        }else{
            UserDefaults.standard.set(true, forKey: "hasAlreadyLaunched")
        }
      
       application.applicationIconBadgeNumber = 0

        return true
        
    }
    
//    func applicationWillResignActive(_ application: UIApplication) {
//
//        UIApplication.shared.applicationIconBadgeNumber = 0
//    }
//
//    private func application(_ application: UIApplication, didReceive notification: UNNotificationRequest) {
//        UIApplication.shared.applicationIconBadgeNumber = 0
//    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
//        UIApplication.shared.applicationIconBadgeNumber = 0
    }
    
    func sethasAlreadyLaunched(){
        hasAlreadyLaunched = true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Sponukannya")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }


//  To make notification visible when it is in the foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    NotificationCenter.default.post(name: NSNotification.Name("ReloadNotification"), object: nil)
        }
    
  
//   Dlya vymknennya nagaduvan' v nagaduvanni
    func userNotificationCenter(_ center: UNUserNotificationCenter,
               didReceive response: UNNotificationResponse,
               withCompletionHandler completionHandler: @escaping () -> Void) {
    // Os' tut my nafig i beremo identifier, kotryj - content.body
            let id = response.notification.request.identifier
//            print("Received notification with ID = \(id)")
            switch response.actionIdentifier {
                case "Do Not Repeat":
                    center.removeDeliveredNotifications(withIdentifiers: [id])
//                print(id)
                default:
                    break
            }
                completionHandler()
        
        }
        
    
//    func printFonts(){
//        for family: String in UIFont.familyNames
//        {
////print("\(family)")
//            for names: String in UIFont.fontNames(forFamilyName: family)
//            {
////print("== \(names)")
//            }
//        }
//    }
    
        
    }

