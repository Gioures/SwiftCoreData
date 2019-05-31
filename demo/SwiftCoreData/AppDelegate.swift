//
//  AppDelegate.swift
//  SwiftCoreData
//
//  Created by 段庆烨 on 2019/5/7.
//  Copyright © 2019年 Gioures. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        return true
    }
    // 版本不同 存储的路径不同
    // MARK: - Core Data存储器 把iOS9以下的各种东西都整合到一起了
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "SwiftCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        // 这里设置路径是为了保持跟iOS9以前的存储路径一致 只有iOS10 i以上 可以不设置
         let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        do{
            try    container.persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        }catch{
            fatalError("路径不存在");
        }
        return container
    }()

   
    // iOS 9 以下
    // 存储路径
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    // 托管对象 也就是 SwiftCoreData.xcdatamodeld 文件。但是类型要写 momd
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: "SwiftCoreData", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    // 存储器 设置路径等
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "创建或加载应用程序保存的数据时出错。"
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            //报告我们得到的任何错误。
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "无法初始化应用程序保存的数据" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    // 托管对象上下文
    lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    
    // MARK： - 核心数据保存支持
    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    //将此实现替换为代码来适当地处理错误。
                    // fatalError（）导致应用程序生成崩溃日志并终止。您不应在运输应用程序中使用此功能，尽管它在开发期间可能很有用。
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } else {
           // iOS 9.0及更低版本 - 但是你以前处理它是
            if managedObjectContext.hasChanges {
                do {
                    try managedObjectContext.save()
                } catch {
                    //用代码替换此实现以适当地处理错误。
                    // abort（）导致应用程序生成崩溃日志并终止。您不应在运输应用程序中使用此功能，尽管它在开发期间可能很有用。
                    let nserror = error as NSError
                    NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                    abort()
                }
            }
            
        }
    }
}

