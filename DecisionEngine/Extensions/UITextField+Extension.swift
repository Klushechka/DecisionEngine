//
//  UITextField+Extension.swift
//  DecisionEngine
//
//  Created by Olga Kliushkina on 04.06.2020.
//  Copyright © 2020 Olga Klyushkina. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    
    func addDoneButtonToKeyboard(myAction: Selector?){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: Constants.done, style: .done, target: self, action: myAction)
        
        var items = [UIBarButtonItem]()
        items.append(flexSpace)
        items.append(done)
        
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
}
