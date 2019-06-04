//
//  EMTAuthenticationViewController.swift
//  HosaProject
//
//  Created by Darvyn Martinez on 2/8/19.
//  Copyright © 2019 Darvyn Martinez. All rights reserved.
//

import UIKit
import LocalAuthentication

class EMTAuthenticationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let myContext = LAContext()
        let myLocalizedReasonString = "Login quickly and securely."
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { success, evaluateError in
                    if success {
                        // User authenticated successfully, take appropriate action
                        
                        DispatchQueue.main.async {
                            self.performSegue(withIdentifier: "emtSignInToTabBar", sender: self)
                        }
                    } else {
                        // User did not authenticate successfully, look at error and take appropriate action
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    @IBAction func signIn(_ sender: Any) {
        self.performSegue(withIdentifier: "emtSignInToTabBar", sender: self)
    }
}
