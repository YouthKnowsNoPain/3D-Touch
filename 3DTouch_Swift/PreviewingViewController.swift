//
//  PreviewingViewController.swift
//  3DTouch_Swift
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class PreviewingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white;
        
        view.addSubview(contentImageView)

    }
    
    // MARK: -- 添加底部菜单
    override var previewActionItems: [UIPreviewActionItem] {
        
        let action1: UIPreviewAction = UIPreviewAction(title: "action1", style: .default) { (action, viewController) in
            
            // 处理操作

        }
        
        let action2: UIPreviewAction = UIPreviewAction(title: "action2", style: .destructive) { (action, viewController) in
            
        }
        
        let action3: UIPreviewAction = UIPreviewAction(title: "action3", style: .selected) { (action, viewController) in
            
        }
        
        return [action1,action2,action3]
    }
    
    // MARK: -- lazy loading
    
    lazy var contentImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT))
        imageView.contentMode = .scaleToFill
        return imageView
    }()
}
