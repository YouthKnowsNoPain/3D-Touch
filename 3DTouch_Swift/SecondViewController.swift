//
//  SecondViewController.swift
//  3DTouch_Swift
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import SafariServices

class SecondViewController: UIViewController,UIViewControllerPreviewingDelegate,SFSafariViewControllerDelegate {

    @IBOutlet weak var goToSafari: UIButton!
    @IBOutlet weak var goToWeb: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // 创建快捷方式的icon
        let shortCutIcon: UIApplicationShortcutIcon = UIApplicationShortcutIcon(templateImageName: "icon_pass") // 自定义
        
//        let shortCutIcon: UIApplicationShortcutIcon = UIApplicationShortcutIcon(type: .play) // 系统
        
        // 创建快捷方式item
        let shortchuItem: UIApplicationShortcutItem = UIApplicationShortcutItem(type: "Second", localizedTitle: "这是第二个", localizedSubtitle: "Second", icon: shortCutIcon, userInfo: nil)
        
        // 添加
        UIApplication.shared.shortcutItems = [shortchuItem]

        self.registerForPreviewing(with: self, sourceView: view)
    }

    @IBAction func changeShortchuItem(_ sender: AnyObject) {
        
        // 获取应用单前所有的动态标签标签，无法获取静态的
        let application: UIApplication = UIApplication.shared
        var shortcutItems: [UIApplicationShortcutItem]? = application.shortcutItems
        
        // 修改应用当前的某个shortcutItems
        let newShortcutItem: UIMutableApplicationShortcutItem = shortcutItems?[0].mutableCopy() as! UIMutableApplicationShortcutItem
        newShortcutItem.localizedTitle = "第二个修改";
        newShortcutItem.icon = UIApplicationShortcutIcon(type: .search)
        
        // 重新添加
        shortcutItems?[0] = newShortcutItem
        application.shortcutItems = shortcutItems;
    }

    @IBAction func openUrlWithSafari(_ sender: AnyObject) {
        
        let safariVC: SFSafariViewController = SFSafariViewController(url: URL(string: "http://www.jianshu.com/p/1d8b3c14393b")!)
        
        self.present(safariVC, animated: true, completion: nil)
        
    }
    // MARK: -- UIViewControllerPreviewingDelegate
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    
        

        if goToWeb.frame.contains(location) {
            
            let webVC: WebPreviewingViewController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "WebPreviewing") as! WebPreviewingViewController
            return webVC
        }
        
        
        if goToSafari.frame.contains(location) {
            
            let safariVC: SFSafariViewController = SFSafariViewController(url: URL(string: "https://www.baidu.com")!)
            
            return safariVC
        }
    
        return nil
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        self.show(viewControllerToCommit, sender: self)
    }

    // MARK: -- SFSafariViewControllerDelegate
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }

}
