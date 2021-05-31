//
//  AppDelegate.swift
//  DrawingAppSwiftUI
//
//  Created by brian은석 on 2021/05/30.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //custom class coredata set
        NSKeyedUnarchiver.setClass(DrawingEntity.self, forClassName: "MyDrawing.DrawingEntity")
        NSKeyedArchiver.setClassName("MyDrawing.DrawingEntity", for: DrawingEntity.self)
        
        DrawSaveDataManager.shared.setup(modelName:"DrawingAppSwiftUI")
        DrawSaveDataManager.shared.getData()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }
    
    
}

