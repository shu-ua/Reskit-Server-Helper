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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = SHRestKitHelper.sharedInstance.baseURL()
        
    }

}

