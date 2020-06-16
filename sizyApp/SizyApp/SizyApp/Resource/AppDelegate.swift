//
//  AppDelegate.swift
//  SizyApp
//
//  Created by 임명준 on 2020/04/30.
//  Copyright © 2020 임명준. All rights reserved.
//

import UIKit
import CoreData
import NaverThirdPartyLogin
import KakaoOpenSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    let instance = NaverThirdPartyLoginConnection.getSharedInstance()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //네이버 앱으로 인증하는 방식을 활성화
        instance?.isNaverAppOauthEnable = true
        //사파리 앱으로 인증
        instance?.isInAppOauthEnable = true
        //세로 모드에서만 인증 허용
        instance?.isOnlyPortraitSupportedInIphone()
        
        // 네이버 아이디로 로그인하기 설정
       // 애플리케이션을 등록할 때 입력한 URL Scheme
        instance?.serviceUrlScheme = kServiceAppUrlScheme
        // 애플리케이션 등록 후 발급받은 클라이언트 아이디
        instance?.consumerKey = kConsumerKey
        // 애플리케이션 등록 후 발급받은 클라이언트 시크릿
        instance?.consumerSecret = kConsumerSecret
        // 애플리케이션 이름
        instance?.appName = kServiceAppName
        
        return true
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return true
    }
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        if KOSession.handleOpen(url) {
            return true
        }
        return false
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
        let container = NSPersistentContainer(name: "SizyApp")
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

}

