//
//  Tools.swift
//  MyTravel
//
//  Created by apple on 16/9/14.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

// MARK:---重绘image
func originImage(_ image:UIImage?, size:CGSize) -> UIImage {
    if UIScreen.main.scale == 2.0 {
        UIGraphicsBeginImageContextWithOptions(size, false, 2.0)
    } else {
        UIGraphicsBeginImageContext(size)
    }
    
    image?.draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
    let scaledImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
    UIGraphicsEndImageContext()
    
    return scaledImage
}

class Tools: NSObject {

}
