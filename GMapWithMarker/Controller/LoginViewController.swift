//
//  LoginViewController.swift
//  GMapWithMarker
//
//  Created by Mariam on 7/13/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        loginButton.permissions = ["public_profile", "email"]
        
//        let fbLoginManager : LoginManager = LoginManager()
//        fbLoginManager.loginBehavior = FBSDKLoginBehavior.Web
//        fbLoginManager.logInWithReadPermissions(["public_profile","email"], fromViewController: self) { (result, error) -> Void in
//            if error != nil {
//                print(error.localizedDescription)
//                self.dismissViewControllerAnimated(true, completion: nil)
//            } else if result.isCancelled {
//                print("Cancelled")
//                self.dismissViewControllerAnimated(true, completion: nil)
//            } else {
//
//            }
//        }
       
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            
            // Print out access token
            print("FB Access Token: \(String(describing: AccessToken.current?.tokenString))")
        }
        
        if let token = AccessToken.current,
            !token.isExpired {
            
           alertWithMessage("logged")
        }

        // Do any additional setup after loading the view.
    }

}
