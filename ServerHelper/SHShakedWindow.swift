//
//  ShakedWindow.swift
//  ServerHelper
//
//  Created by Bohdan Sh on 11/17/15.
//  Copyright © 2015 Bohdan Shcherbyna. All rights reserved.
//

import UIKit

class SHShakedWindow: UIWindow {
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if (motion == UIEventSubtype.MotionShake) {
            print("shake")
            self.showSelectServerDialog()
        }
    }
    
    func setupServerHelper() {
        dispatch_async(dispatch_get_main_queue(),{
            self.rootViewController = self.serverDialogVC()
        })
    }
    
    private func showSelectServerDialog() {
        
        let helperVC = serverDialogVC()
        
        if let vc = self.rootViewController {
            helperVC.modalPresentationStyle = UIModalPresentationStyle.FullScreen
            helperVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
            vc.showViewController(helperVC, sender: vc)
        }
    }
    
    private func serverDialogVC() -> SHSelectServerHelperDialogVC {
        let helperStoryboard = UIStoryboard(name: "SHServerHelperStoryboard", bundle: nil)
        return helperStoryboard.instantiateViewControllerWithIdentifier("SHSelectServerHelperDialogVC") as! SHSelectServerHelperDialogVC
    }
    
    
    
}
