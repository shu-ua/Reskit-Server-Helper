//
//  ViewController.swift
//  ServerHelper
//
//  Created by Bohdan Sh on 11/13/15.
//  Copyright © 2015 Bohdan Shcherbyna. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var entityInfoLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        updateEntitiInfoLabel()
        textLabel.text = SHRestKitHelper.baseURL()
    }
    
    func addEntity() {
        let value = TestValue(managedObjectContext: RKObjectManager.sharedManager().managedObjectStore.mainQueueManagedObjectContext)
        value.text = NSDate()
        
        SHRestKitHelper.saveContext()
    }
    
    func updateEntitiInfoLabel() {
        entityInfoLabel.text = "Current entity count - \(TestValue.getCount())"
    }
    
    @IBAction func addEntityTouchUp(sender: AnyObject) {
        addEntity()
        updateEntitiInfoLabel()
    }

}

