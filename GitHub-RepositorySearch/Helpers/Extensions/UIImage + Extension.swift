//
//  UIImage + Extension.swift
//  GitHub-RepositorySearch
//
//  Created by Nazmul on 17/03/2023.
//

import Foundation
import UIKit.UIImage

extension UIImage {
    
    func imgly_normalizedImageOfSize(_ size: CGSize) -> UIImage {
        autoreleasepool {
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            draw(in: CGRect(origin: CGPoint.zero, size: size))
            let normalizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return normalizedImage ?? UIImage()
        }
    }
    
    func resizeImage(img: UIImage?) -> UIImage {
        
        autoreleasepool {
            if let image = img {
                let maxLowResolutionSideLength = CGFloat(150)
                if image.size.width > maxLowResolutionSideLength || image.size.height > maxLowResolutionSideLength  {
                    let scale: CGFloat
                    
                    if(image.size.width > image.size.height) {
                        scale = maxLowResolutionSideLength / image.size.width
                    } else {
                        scale = maxLowResolutionSideLength / image.size.height
                    }
                    
                    let newWidth  = CGFloat(roundf(Float(image.size.width) * Float(scale)))
                    let newHeight = CGFloat(roundf(Float(image.size.height) * Float(scale)))
                    let resizeImg = image.imgly_normalizedImageOfSize(CGSize(width: newWidth, height: newHeight))
                    return resizeImg
                }
            }
            return UIImage()
        }
    }
}


