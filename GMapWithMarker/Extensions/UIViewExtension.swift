//
//  Extentions.swift
//  GMapWithMarker
//
//  Created by Mariam on 2/22/2563 BE.
//  Copyright © 2563 BE Mariam. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}
