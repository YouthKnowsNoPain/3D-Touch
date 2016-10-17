//
//  CalculateCellHeight.swift
//  MyTravel
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
// 根据文字和图片计算cell的高度

class CalculateCellHeight: NSObject {
    
    // 图片数量
    open var numOfImage: Int = 0
    // 文字
    open var contentText: NSString?
    // 设置最大的宽度默认屏幕宽度
    open var maxWidth: CGFloat = UIScreen.main.bounds.size.width
    // 图片间隔，默认5
    open var imageSpace: CGFloat = 5.0
    // 一排最多有几张图片, 默认3张
    open var maxNumImageOfRow: Int = 3
    // 设置字体大小,默认15
    open var textFont: UIFont = UIFont.systemFont(ofSize: 15)

    // 计算文本高度
    open func calclateTextHeight() -> CGFloat {
        let textMaxSize = CGSize(width: maxWidth, height: 100000.0)
        
        let attributes: Dictionary = [NSFontAttributeName:textFont]
        
        if contentText == nil || contentText?.length == 0 {
            return 5
        }
        
        var textHeight: CGFloat = contentText!.boundingRect(with: textMaxSize, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size.height+21
        
        if textHeight < 30.0 {
            textHeight = 30.0
        }
        
        return textHeight
    }
    
    // 计算图片高度
    open func calclateImagesHeight() -> CGFloat {
        // 图片总的高度
        var imageHeight: CGFloat = 0.0
        // 单个图片的高度
        let imageHeightOfRow: CGFloat = (maxWidth-CGFloat(maxNumImageOfRow-1)*imageSpace)/CGFloat(maxNumImageOfRow)
        
        let row = ceil(CGFloat(numOfImage) / CGFloat(maxNumImageOfRow))
        imageHeight = imageHeightOfRow*row + (row-1)*imageSpace
        
        return imageHeight
    }
    
    // 开始计算
    open func startCalclateCellHeight() -> CGFloat {

        return calclateTextHeight()+calclateImagesHeight()+10
    }

}
