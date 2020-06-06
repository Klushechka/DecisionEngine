//
//  BordlessLabel.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 04.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation
import UIKit

final class BorderlessTextField: UITextField {
    
    private var bottomLineLayer: CALayer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        decorateTextField()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
        decorateTextField()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setBottomLine()
    }
    
    private func decorateTextField() {
        self.font = UIFont.systemFont(ofSize: 25, weight: .light)
    }
    
    private func setBottomLine() {
        self.bottomLineLayer?.removeFromSuperlayer()
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 0.5)
        bottomLine.backgroundColor = UIColor.lightGray.cgColor
        
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
        
        self.bottomLineLayer = bottomLine
    }
    
}
