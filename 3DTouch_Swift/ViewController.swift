//
//  ViewController.swift
//  3DTouch_Swift
//
//  Created by apple on 16/10/13.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch: UITouch = touches.first!
        
        print("force = \(touch.force)\n,max = \(touch.maximumPossibleForce)\n,scale = \(touch.force/touch.maximumPossibleForce)")
        
        let scale = 1.0-touch.force/touch.maximumPossibleForce
        
        view.backgroundColor = UIColor(red: 1.0, green: scale, blue: scale, alpha: 1.0)
    }
    
}

