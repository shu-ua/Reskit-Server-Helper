//
//  SHAddServerDialogVC.swift
//  ServerHelper
//
//  Created by Bohdan Sh on 11/17/15.
//  Copyright © 2015 Bohdan Shcherbyna. All rights reserved.
//

import UIKit

class SHSelectServerHelperDialogVC: UIViewController {

    @IBOutlet weak var serverURLTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func changeServerTouchUp(sender: AnyObject) {
        self.view.endEditing(true)
        SHRestKitHelper.sharedInstance.changeBaseUrl(serverURLTextField.text!)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.application(UIApplication.sharedApplication(), didFinishLaunchingWithOptions: nil)
    }

}
