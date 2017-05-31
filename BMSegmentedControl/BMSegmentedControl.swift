//
//  SegmentedControl.swift
//  Segmented
//
//  Created by Dwi Permana Putra on 5/30/16.
//  Forked by Bruno Miguens on 30/05/2017.
//  Copyright © 2016 Dwi Permana Putra. All rights reserved.
//

import UIKit

enum ComponentOrientation {
    case topDown
    case leftRight
}

class BMSegmentedControl: UIControl {
    
    fileprivate var componentOrientation: ComponentOrientation = ComponentOrientation.leftRight
    
    fileprivate var labels = [UILabel]()
    fileprivate var icons = [UIImageView]()
    fileprivate var selectedLabel = UILabel()
    
    fileprivate var imgIcon = UIImageView()
    fileprivate var selectedImgIcon = UIImageView()
    
    fileprivate var withIcon: Bool = true
    
    fileprivate func setOrientation(_ orientation: ComponentOrientation) {
        switch orientation {
        case .leftRight:
            componentOrientation = ComponentOrientation.leftRight
        case .topDown:
            componentOrientation = ComponentOrientation.topDown
        }
    }
    
    open fileprivate(set) var thumbColor: UIColor = .white {
        didSet {
            setThumbColor()
        }
    }
    
    fileprivate func setThumbColor() {
        thumbView.backgroundColor = thumbColor
    }
    
    open fileprivate(set) var textColor: UIColor = .white
    
    fileprivate func setTextColor() {
        for i in 0..<labels.count {
            labels[i].textColor = textColor
            labels[i].font = UIFont(name: "HelveticaNeue", size: 14.0)
            if i < icons.count {
                icons[i].tintColor = textColor
            }
        }
    }
    
    open fileprivate(set) var selectedTextColor: UIColor = .black {
        didSet {
            setSelectedTextColor()
        }
    }
    
    fileprivate func setSelectedTextColor() {
        selectedLabel.textColor = selectedTextColor
    }
    
    fileprivate var thumbView = UIView()
    
    open fileprivate(set) var items: [String] = []
    
    fileprivate var icon: [UIImage] = []
    fileprivate var selectedIcon: [UIImage] = []
    
    var selectedIndex: Int = 0 {
        didSet {
            displayNewSelectedIndex()
        }
    }
    
    init(withoutIcon frame: CGRect, items: [String], backgroundColor: UIColor, thumbColor: UIColor, textColor: UIColor, selectedTextColor: UIColor) {
        super.init(frame: frame)
        self.items = items
        self.backgroundColor = backgroundColor
        self.thumbColor = thumbColor
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.componentOrientation = ComponentOrientation.topDown
        self.withIcon = false
        setupView()
    }
    
    init(withIcon frame: CGRect, items: [String], icons: [UIImage], selectedIcons: [UIImage], backgroundColor: UIColor, thumbColor: UIColor, textColor: UIColor, selectedTextColor: UIColor, orientation: ComponentOrientation) {
        super.init(frame: frame)
        self.items = items
        self.icon = icons
        self.selectedIcon = selectedIcons
        self.backgroundColor = backgroundColor
        self.thumbColor = thumbColor
        self.textColor = textColor
        self.selectedTextColor = selectedTextColor
        self.componentOrientation = orientation
        setupView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    fileprivate func getIconFrameByOrientation(_ orientation: ComponentOrientation, index: Int, text: String) -> CGRect {
        let width = self.bounds.width/CGFloat(items.count)
        let height = self.bounds.height
        let iconX = getIconX(width, textWidth: evaluateStringWidth(text))
        let x = width*CGFloat(index-1)
        
        switch orientation {
        case .leftRight:
            let evaluateIconX = x + iconX
            let iconRect = CGRect(x: evaluateIconX, y: 0, width: 16, height: height)
            return iconRect
        case .topDown:
            let centre: CGFloat = x + ((width-16)/2)
            let iconRect = CGRect(x: centre, y: 7, width: 16, height: 16)
            return iconRect
        }
    }
    
    fileprivate func getTextFrameByOrintation(_ orientation: ComponentOrientation, text: String, index: Int) -> CGRect {
        let height = self.bounds.height
        let width = self.bounds.width/CGFloat(items.count)
        let textX = getTextX(width, textWidth: evaluateStringWidth(text))
        let xPosition = CGFloat(index) * width
        let evaluateTextX = xPosition + textX
        
        switch orientation {
        case .leftRight:
            let textRect = CGRect(x: evaluateTextX, y: 0, width: width, height: height)
            return textRect
        case .topDown:
            let centre = evaluateTextX - 13
            let textRect: CGRect?
            if withIcon {
                textRect = CGRect(x: centre, y: 18, width: width, height: 25)
            } else {
                textRect = CGRect(x: centre, y: 0, width: width, height: height)
            }
            return textRect!
        }
    }
    
    fileprivate func setupView() {
        layer.cornerRadius = 5
        setupLabels()
        insertSubview(thumbView, at: 0)
    }
    
    fileprivate func setupLabels() {
        guard items.count > 0 else {
            return
        }
        
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll(keepingCapacity: true)
        
        for index in 1...items.count {
            
            let view = UIView.init(frame: CGRect.zero)
            
            let label = UILabel(frame: CGRect.zero)
            label.text = items[index-1]
            label.textColor = textColor
            view.addSubview(label)
            labels.append(label)
            
            let text = items[index-1]
            
            if withIcon {
                self.imgIcon = UIImageView(frame: getIconFrameByOrientation(self.componentOrientation, index: index, text: text))
                self.imgIcon.contentMode = .scaleAspectFit
                self.imgIcon.image = icon[index-1]
                
                view.addSubview(self.imgIcon)
                icons.append(self.imgIcon)
            }
            
            self.addSubview(view)
            
        }
        setTextColor()
        
    }
    
    fileprivate func getIconX(_ itemWidth: CGFloat, textWidth: CGFloat) -> CGFloat {
        let iconWidth: CGFloat = 16.0
        let avg = iconWidth + textWidth
        let space: CGFloat = (itemWidth - avg) / 2
        
        return space + 2
    }
    
    fileprivate func getTextX(_ itemWidth: CGFloat, textWidth: CGFloat) -> CGFloat {
        var iconWidth:CGFloat = withIcon ? 16.0 : 0.0
        
        let avg = iconWidth + textWidth
        let space: CGFloat = (itemWidth - avg) / 2
        
        let x = space + iconWidth
        
        return x + 8
    }
    
    internal override func layoutSubviews() {
        super.layoutSubviews()
        
        var selectedFrame = self.bounds
        let newWidth = selectedFrame.width / CGFloat(items.count)
        selectedFrame.size.width = newWidth
        
        selectedFrame.origin.x = selectedFrame.origin.x + 4
        selectedFrame.origin.y = selectedFrame.origin.y + 4
        selectedFrame.size.width = selectedFrame.width - 8
        selectedFrame.size.height = selectedFrame.height - 8
        
        if selectedIndex > 0 {
            setTextColor()
            setSelectedTextColor()
            thumbView.frame = setDefaultSelectionPoint(selectedIndex)
        } else {
            thumbView.frame = selectedFrame
        }
        
        thumbView.backgroundColor = thumbColor
        thumbView.layer.cornerRadius = 5
        
        for index in 0...labels.count - 1 {
            let label = labels[index]
            
            let text = items[index]
            
            label.frame = getTextFrameByOrintation(self.componentOrientation, text: text, index: index)
            
        }
    }
    
    fileprivate func evaluateStringWidth(_ textToEvaluate: String) -> CGFloat {
        let lbl = UILabel(frame: CGRect.zero)
        lbl.text = textToEvaluate
        lbl.sizeToFit()
        
        return lbl.frame.width
    }
    
    internal override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let location = touch.location(in: self)
        
        let labelWidth = self.bounds.width / CGFloat(items.count)
        
        var calculatedIndex: Int?
        for (index, item) in labels.enumerated() {
            
            let text = items[index]
            
            let iconX = getIconX(labelWidth, textWidth: evaluateStringWidth(text))
            
            let frame = CGRect(x: item.frame.origin.x - (iconX*2), y: 0, width: item.frame.width, height: self.bounds.height)
            
            if frame.contains(location) {
                calculatedIndex = index
            } else {
                item.textColor = textColor
                if withIcon {
                    icons[index].image = icon[index]
                }
                
            }
        }
        
        if calculatedIndex != nil {
            selectedIndex = calculatedIndex!
            sendActions(for: .valueChanged)
        }
        return false
    }
    
    fileprivate func displayNewSelectedIndex() {
        guard selectedIndex < labels.count else {
            return
        }
        
        selectedLabel = labels[selectedIndex]
        selectedLabel.textColor = selectedTextColor
        
        if withIcon {
            selectedImgIcon = icons[selectedIndex]
            selectedImgIcon.image = selectedIcon[selectedIndex]
            selectedImgIcon.tintColor = selectedTextColor
        }
        
        let text = items[selectedIndex]
        
        let labelWidth = self.bounds.width / CGFloat(items.count)
        let iconX = getTextX(labelWidth, textWidth: evaluateStringWidth(text))
        
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            var labelFrame = self.selectedLabel.bounds
            
            print("selectedLabel: \(self.selectedLabel.frame.origin.x)")
            
            if self.componentOrientation == ComponentOrientation.topDown {
                labelFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4 + 13
            } else {
                labelFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4
            }
            
            labelFrame.origin.y = 4
            labelFrame.size.width = self.selectedLabel.frame.width - 8
            labelFrame.size.height = self.bounds.height - 8
            
            self.thumbView.frame = self.setDefaultSelectionPoint(self.selectedIndex)
            
        }, completion: nil)
        
    }
    
    fileprivate func setDefaultSelectionPoint(_ index: Int) -> CGRect {
        let selectedLabel = labels[index]
        var selectedFrame = selectedLabel.bounds
        
        if withIcon {
            selectedImgIcon = icons[selectedIndex]
            selectedImgIcon.image = selectedIcon[selectedIndex]
        }
        
        let text = items[selectedIndex]
        let labelWidth = self.bounds.width / CGFloat(items.count)
        let iconX = getTextX(labelWidth, textWidth: evaluateStringWidth(text))
        
        if self.componentOrientation == ComponentOrientation.topDown {
            selectedFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4 + 13
        } else {
            selectedFrame.origin.x = self.selectedLabel.frame.origin.x - iconX + 4
        }
        selectedFrame.origin.y = 4
        selectedFrame.size.width = self.selectedLabel.frame.width - 8
        selectedFrame.size.height = self.bounds.height - 8
        return selectedFrame
    }
    
}
