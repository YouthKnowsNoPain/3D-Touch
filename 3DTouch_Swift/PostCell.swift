//
//  PostCell.swift
//  MyTravel
//
//  Created by apple on 16/9/21.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit
import XHImageViewer
import SnapKit

class PostCell: UITableViewCell {

    // 图片url数组
    var imageUrls:[String] = [] {
        didSet {
            setupImageGroupView()
        }
    }
    // imageView数组
    var imageViews:[UIImageView] = []
    
    // 图片群
    var imageGroupView: UIView = UIView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        buildUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init coder is error")
    }
    
    fileprivate func buildUI() {
        
        contentView.addSubview(headImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(genderImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(imageGroupView)
        
        headImageView.snp.makeConstraints { (make) in
            make.top.left.equalTo(10)
            make.width.height.equalTo(50)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView.snp.right).offset(10)
            make.top.equalTo(headImageView.snp.top)
            make.width.equalTo(100)
            make.height.equalTo(25)
        }
        
        genderImageView.snp.makeConstraints { (make) in
            make.left.equalTo(headImageView.snp.right).offset(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.width.height.equalTo(15)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.left.equalTo(nameLabel.snp.right).offset(10)
            make.top.equalTo(nameLabel.snp.top)
            make.height.equalTo(nameLabel.snp.height)
        }
        
        timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.left.equalTo(titleLabel.snp.left)
            make.top.equalTo(genderImageView.snp.top)
            make.height.equalTo(genderImageView.snp.height)
        }
        
    }
    
    // MARK: -- 视图布局
    override func layoutSubviews() {
        super.layoutSubviews()

        let calculate: CalculateCellHeight = CalculateCellHeight()
        
        calculate.maxWidth = SCREEN_WIDTH-20
        calculate.textFont = CELL_TEXT_FONT
        calculate.contentText = contentLabel.text as NSString?
        calculate.numOfImage = imageUrls.count

        contentLabel.frame = CGRect(x: 10.0, y: headImageView.frame.maxY+10.0, width: SCREEN_WIDTH-20.0, height: calculate.calclateTextHeight())
        
        imageGroupView.frame = CGRect(x: 10.0, y: contentLabel.frame.maxY, width: SCREEN_WIDTH-20.0, height: calculate.calclateImagesHeight())
        
    }
    
    fileprivate func setupImageGroupView() {
        
        if imageViews.count != 0 {
            for imageView in imageViews {
                imageView.removeFromSuperview()
            }
            imageViews.removeAll()
        }
        
        // 每行最多3个图片，每个图片的高度 ＝ (最大宽度 － 空格) / 3
        let space: CGFloat = 5.0
        let imageWidth = ((SCREEN_WIDTH-20.0)-2.0*space) / 3.0
        let imageHeight = imageWidth
        
        for (index, imageUrl) in imageUrls.enumerated() {
            let row = index / 3
            let loc = index % 3
            
            let x = (space + imageWidth) * CGFloat(loc)
            let y = (space + imageHeight) * CGFloat(row)
            
            let imageView: UIImageView = UIImageView(frame: CGRect(x: x, y: y, width: imageWidth, height: imageHeight))
            imageView.image = UIImage(named: imageUrl)
            imageGroupView.addSubview(imageView)
            imageViews.append(imageView)
            
            imageView.isUserInteractionEnabled = true
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(tapGestureEvent(gestrue:)))
            imageView.addGestureRecognizer(tapGesture)
            
        }
    }
    
    func tapGestureEvent(gestrue: UITapGestureRecognizer) {
        let imgageViewer: XHImageViewer = XHImageViewer()
        imgageViewer.show(withImageViews: imageViews, selectedView: gestrue.view as! UIImageView!)
    }
    
    // MARK: -- lazy loading
    // 头像
    lazy var headImageView: UIImageView = {
        let imageView: UIImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0))
        imageView.layer.cornerRadius = imageView.bounds.size.height/2
        imageView.layer.masksToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        
        return imageView
    }()
    
    // 姓名
    lazy var nameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = CELL_TEXT_FONT
        label.text = "name"
        label.textAlignment = .left
        return label
    }()
    
    // 性别标识
    lazy var genderImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    // 标题
    lazy var titleLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = CELL_TEXT_FONT
        label.text = "title"
        label.textAlignment = .right
        return label
    }()
    
    // 时间
    lazy var timeLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = ANGLE_TEXT_FONT
        label.textColor = .gray
        label.text = "123465"
        label.textAlignment = .right
        return label
    }()
    
    // 内容
    lazy var contentLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = CELL_TEXT_FONT
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // 几人加入
    lazy var numLabel: UILabel = {
        let label: UILabel = UILabel()
        label.font = ANGLE_TEXT_FONT
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
}
