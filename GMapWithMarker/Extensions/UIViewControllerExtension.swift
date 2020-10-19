//
//  UIViewControllerExtension.swift
//  GMapWithMarker
//
//  Created by Mariam on 2/25/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController{
    func  alertWithMessage(_ message: String = "", title: String = "") {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction.init(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

