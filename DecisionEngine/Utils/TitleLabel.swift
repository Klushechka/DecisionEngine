//
//  TitleLabel.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 04.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation
import UIKit

final class TitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        decorateLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
        decorateLabel()
    }
    
    private func decorateLabel() {
        self.textColor = .darkGray
        self.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    }
    
}
