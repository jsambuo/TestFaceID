//
//  ViewController.swift
//  TestFaceID
//
//  Created by Sambuo, Jimmy on 10/2/17.
//  Copyright © 2017 Sambuo, Jimmy. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBAction func buttonTapped(_ sender: Any) {
        // Code example from https://developer.apple.com/documentation/localauthentication
        let myContext = LAContext()
        let myLocalizedReasonString = "FaceID test"
        
        var authError: NSError?
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if myContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                myContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: myLocalizedReasonString) { [unowned self] success, evaluateError in
                    DispatchQueue.main.async {
                        if success {
                            // User authenticated successfully, take appropriate action
                            self.displayLabel?.text = "success"
                        } else {
                            // User did not authenticate successfully, look at error and take appropriate action
                            self.displayLabel?.text = "Error: \(evaluateError.debugDescription)"
                        }
                    }
                }
            } else {
                // Could not evaluate policy; look at authError and present an appropriate message to user
                let message = authError?.debugDescription ?? "nil"
                self.displayLabel?.text = "No biometrics available: \(message)"
            }
        } else {
            // Fallback on earlier versions
            self.displayLabel?.text = "iOS version too early."
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

