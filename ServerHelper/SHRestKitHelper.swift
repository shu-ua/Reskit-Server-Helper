//
//  RestKitHelper.swift
//  ServerHelper
//
//  Created by Bohdan Sh on 11/13/15.
//  Copyright © 2015 Bohdan Shcherbyna. All rights reserved.
//

import UIKit

class SHRestKitHelper {
    
    static let sharedInstance = SHRestKitHelper()
    var manager : RKObjectManager!
    var managedObjectStore: RKManagedObjectStore!
    
    init() {
        managedObjectStore = RKManagedObjectStore(managedObjectModel: NSManagedObjectModel.mergedModelFromBundles(nil))
        
        var error: NSError?
        if !RKEnsureDirectoryExistsAtPath(RKApplicationDataDirectory(), &error) {
            NSLog("Failed to create Application Data Directory at path '%@': %@", RKApplicationDataDirectory(), error!)
            abort()
        }
        
        if (SHRestKitHelper.baseURL() != nil) {
            createPersistentStore(managedObjectStore, pathToPersistentStore: self.persistentStorePath())
            managedObjectStore.createManagedObjectContexts()
            initManager()
        }
    }
    
    class func checkForNeedingStartInit() -> Bool {
        
        if SHRestKitHelper.baseURL() == nil {
            if let appDelegate = UIApplication.sharedApplication().delegate as? AppDelegate {
                appDelegate.customWindow?.setupServerHelper()
                return true
            }
        }
        return false
    }
    
    //MARK: - Persistent store
    
    func createPersistentStore(managedObjectStore : RKManagedObjectStore, pathToPersistentStore : String) {
        var persistentStore: NSPersistentStore!
        
        var error: NSError?
        
        do {
            persistentStore = try managedObjectStore.addSQLitePersistentStoreAtPath(pathToPersistentStore, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: nil)
        } catch let error1 as NSError {
            error = error1
            persistentStore = nil
        }
        
        if persistentStore == nil {
            NSLog("Failed adding persistent store at path '%@': %@", pathToPersistentStore, error!)
            NSLog("Recreating store")
            
            do {
                try NSFileManager.defaultManager().removeItemAtPath(pathToPersistentStore)
            } catch _ {
                print("Cant remove path")
                //abort()
            }
            
            do {
                persistentStore = try managedObjectStore.addSQLitePersistentStoreAtPath(pathToPersistentStore, fromSeedDatabaseAtPath: nil, withConfiguration: nil, options: nil)
            } catch let error1 as NSError {
                error = error1
                persistentStore = nil
            }
            if persistentStore == nil {
                NSLog("Really failed adding persistent store at path '%@': %@", pathToPersistentStore, error!);
                //                abort();
            }
        }
        
        initManager()
    }
    
    func recreateManagedObjectStore(pathToPersistentStore : String) -> Bool {
        
        do {
            
            RKObjectManager.sharedManager().operationQueue.cancelAllOperations()
            NSURLCache.sharedURLCache().removeAllCachedResponses()
            RKObjectRequestOperation.responseMappingQueue().cancelAllOperations()
            
            try managedObjectStore.resetPersistentStores()
        } catch _ {
            print("Cant resetting")
            return false
        }
        
//        dispatch_async(dispatch_get_main_queue(),{
//            do {
//                try NSFileManager.defaultManager().removeItemAtPath(pathToPersistentStore)
//            } catch _ {
//                print("Cant remove path")
//                return false
//                //abort()
//            }
////        })
//        
//        createPersistentStore(managedObjectStore, pathToPersistentStore: pathToPersistentStore)
        
        return true
    }
    
    private func persistentStorePath() -> String
    {
        var projectName : String = "Project"
        if let displayName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleDisplayName") as? String {
            projectName = displayName
        }
        
        return RKApplicationDataDirectory().stringByAppendingString("/\(projectName).sqlite")
    }
    
    //MARK: - BaseURL
    
    private func saveBaseUrl(baseUrl : String) {
        NSUserDefaults.standardUserDefaults().setObject(baseUrl, forKey: "RESTKIT_BASE_URL")
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    class func baseURL() -> String?
    {
        return NSUserDefaults.standardUserDefaults().objectForKey("RESTKIT_BASE_URL") as? String
    }
    
    func changeBaseUrl(baseUrl : String) {
        
        if let currentBaseURL = SHRestKitHelper.baseURL() {
            if (baseUrl != currentBaseURL) {
                recreateManagedObjectStore(persistentStorePath())
            }
        } else {
            createPersistentStore(managedObjectStore, pathToPersistentStore: persistentStorePath())
        }
        
        saveBaseUrl(baseUrl)
        initManager()
    }
    
    //MARK: - RKObjectManager
    
    private func initManager() {
        if let baseURL = SHRestKitHelper.baseURL() {
            let manager = RKObjectManager(baseURL: NSURL(string: baseURL))
            manager.managedObjectStore = managedObjectStore
        }
    }
    
    //MARK: - Context
    
    class func saveContext() {
        let error = NSErrorPointer()
        do {
            try RKManagedObjectStore.defaultStore().mainQueueManagedObjectContext.saveToPersistentStore()
        } catch let error1 as NSError {
            error.memory = error1
        }
        if (error != nil) {
            print ("Save error : \(error)")
        }
    }
    
    

}
