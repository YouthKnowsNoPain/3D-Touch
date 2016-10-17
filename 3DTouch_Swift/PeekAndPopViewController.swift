//
//  PeekAndPopViewController.swift
//  3DTouch_Swift
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import XHImageViewer

class PeekAndPopViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UIViewControllerPreviewingDelegate {

    let identifier = "POSTCELL"
    var info: [[String: String]]?
    var images: [[String]]?
    var currentCell: PostCell?
    var currentImageIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initUserInterface()
    }

    fileprivate func initUserInterface() {
        
        view.addSubview(tableView)
    
        info = [["name":"小白",
                 "title":"title",
                 "time":"2013-05-04",
                 "content":"撒娇公交卡就噶加快了大家赶快拉啊健康就噶结果就啊就觉得购物节咕叽咕叽啊哦额就哦格拉的结果就啊过来骄傲的进攻啊就给大家哦啊结果就啊古灵精怪垃圾筐伤筋动骨"],
                ["name":"小白",
                 "title":"title",
                 "time":"2013-05-04",
                 "content":"撒娇公交卡就噶"],
                ["name":"小白",
                 "title":"title",
                 "time":"2013-05-04",
                 "content":""],
                ["name":"小白",
                 "title":"title",
                 "time":"2013-05-04",
                 "content":"撒娇公交卡就噶加快了大家赶快拉结果就啊韩国就啊看过哈看哈嘎哈根据客户定位 i 哈瓦那很快就会改噶可怜见的空间啊购物干辣椒是冠军奥IE上过就啊就噶就噶就噶个结果就噶就看过就啊哦 i 孤傲结束的感觉啊看了就噶噶结果了啊古灵精怪垃圾筐沙发嘎嘎即可可怜见的空间啊购物干辣椒是冠军奥IE上过就啊就噶就噶就噶个结果就噶就看过就啊哦"]]
        
        images = [["23","11","23","77"],
                  [],
                  ["11","23","77","hhh","23","23","77"],
                  ["77","hhh","23"]]
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PostCell.self, forCellReuseIdentifier: identifier)
        
        // 3DTouch注册
        if detection3DTouchIsAvailable() {
            self.registerForPreviewing(with: self, sourceView: tableView)
        }
        
    }
    
    // 检测3DTouch可不可用
    func detection3DTouchIsAvailable() -> Bool {
        return self.traitCollection.forceTouchCapability == .available ? true : false
    }
    
    // MARK: -- UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
       
        print(#function)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let dic = info![indexPath.section]
        let imageArray = images![indexPath.section]
       
        let calculate: CalculateCellHeight = CalculateCellHeight()
        calculate.numOfImage = imageArray.count
        calculate.maxWidth = SCREEN_WIDTH-20
        calculate.textFont = CELL_TEXT_FONT
        calculate.contentText = dic["content"] as NSString!
        
        let height = calculate.startCalclateCellHeight()+70.0
        
        return height
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return  CGFloat(FLT_MIN)
        }
        return 5.0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat(FLT_MIN)
    }
    
    // MARK: -- UITableViewDataSource
    func numberOfSections(in tableView: UITableView) -> Int {
        return (info?.count)!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PostCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! PostCell
    

        let imageArray = images![indexPath.section]
        print(imageArray)
        
        
        let dic = info![indexPath.section]
   
        
        cell.imageUrls = imageArray
        cell.contentLabel.text =  dic["content"]
        cell.headImageView.image = UIImage(named: "head")
        cell.genderImageView.image = UIImage(named: "icon_male")
        
        return cell
    }
    
    // MARK: -- UIViewControllerPreviewingDelegate
    
    // Peek
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        print(#function)

        // 点击点在那个cell上
        let indexPath = tableView.indexPathForRow(at: location)
        let cell: PostCell = tableView.cellForRow(at: indexPath!) as! PostCell
        
        // 转换坐标系
        let pointToCell: CGPoint = tableView.convert(location, to: cell.contentView)
        let pointToImageGroupView: CGPoint = cell.contentView.convert(pointToCell, to: cell.imageGroupView)
        
        // 判断点击的点是否在某个imageView上
        var isContains = false
        var imageIndex = 0
        for (index, imageView) in cell.imageViews.enumerated() {
            
            if imageView.frame.contains(pointToImageGroupView) {
                isContains = true
                imageIndex = index;
                break
            }
        }
        
        // 如果没有返回nil
        if !isContains {
            return nil
        }
        
        // 有，做相应处理
        print("index = \(imageIndex)")
        currentCell = cell
        currentImageIndex = imageIndex
    
        let previewingVC: PreviewingViewController = PreviewingViewController()
        previewingVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
//        previewingContext.sourceRect = CGRect(x: 20, y: 20, width: 100, height: 100) // 原始位置、大小
        previewingVC.contentImageView.image = cell.imageViews[imageIndex].image
        
        return previewingVC
    }
    
    // Pop
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        print(#function)
        
//        self.show(viewControllerToCommit, sender: self)
        
        let imgageViewer: XHImageViewer = XHImageViewer()
        imgageViewer.show(withImageViews: currentCell?.imageViews, selectedView: currentCell?.imageViews[currentImageIndex!])
    }
    
    // MARK: -- lazy loading
    lazy var tableView: UITableView = {
        let tableView: UITableView = UITableView(frame: CGRect(x: 0.0, y: 0.0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), style: .grouped)
        tableView.backgroundColor = BACKGROUND_COLOR
        
        return tableView
    }()
    
   

}
