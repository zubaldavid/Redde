//
//  UIImage+Extensions.swift
//  Redde
//
//  Created by David Zubal on 12/23/18.
//  Copyright © 2018 David Zubal. All rights reserved.
//

import UIKit

extension UIImage {
    class func imageFromColor(_ color: UIColor) -> UIImage {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
}
