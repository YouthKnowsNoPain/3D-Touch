//
//  HK_WebProgress.swift
//  3DTouch_Swift
//
//  Created by apple on 16/10/17.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class HK_WebProgress: CAShapeLayer {
    
    let timeInterval: TimeInterval = 0.05
    
    var plusWidth: CGFloat = 0.05
    var maxWidth: CGFloat = UIScreen.main.bounds.size.width
    
    fileprivate var timer: Timer?
    
    override init() {
        super.init()
        initialize()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    fileprivate func initialize() {
        
        self.lineWidth = 3.0
        self.strokeColor = UIColor.cyan.cgColor
        
        let path: UIBezierPath = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: maxWidth, y: 0))
        
        self.path = path.cgPath
        self.strokeEnd = 0.0
        
    }
    
    // MARK: -- 开始加载
    func startLoad() {
        creatTimer()
    }
    
    // MARK: -- 结束加载
    func finishedLoad() {
        print(#function)
        closeTimer()
        self.strokeEnd = 1.0
        
        weak var weakSelf =  self
        DispatchQueue.main.asyncAfter(deadline: .now()+0.25) { 
            weakSelf?.removeFromSuperlayer()
        }
    }
    
    func pathChanged(timer: Timer) {
   
        guard self.strokeEnd < 0.95 else {
            closeTimer()
            return
        }
        self.strokeEnd = self.strokeEnd + plusWidth
        
    }
    
    // MARK: -- timer
    func creatTimer() {
        
        guard timer == nil else {
            timer?.fire()
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(pathChanged(timer:)), userInfo: nil, repeats: true)
        timer?.fire()
    }
    
    func pauseTimer() {
        guard timer != nil else {
            return
        }
        
        timer?.fireDate = NSDate.distantFuture
    }
    
    func closeTimer() {
        guard timer != nil else {
            return
        }
        
        print(#function)
        
        timer?.invalidate()
        timer = nil
    }

}
