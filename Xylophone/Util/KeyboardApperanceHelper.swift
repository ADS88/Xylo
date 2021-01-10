//
//  KeyboardApperanceHelper.swift
//  Xylophone
//
//  Created by Andrew on 10/01/21.
//

import UIKit

struct KeyboardAppearanceHelper {
    func setupKeyboard(_ buttons: [UIButton], withAppearance appearance: String){
        switch appearance {
        case "Black Keys":
            coloredKeyBoard(buttons: buttons, color: .black)
        case "Gold Keys":
            coloredKeyBoard(buttons: buttons, color: .yellow)
        case "Invisible Keys":
            invisibleKeys(buttons: buttons)
        case "Pretty Pink":
            coloredKeyBoard(buttons: buttons, color: .systemPink)
        default:
            break
        }
    }
    
    func invisibleKeys(buttons: [UIButton]){
        buttons.forEach{
            button in button.backgroundColor = .systemBackground
            button.tintColor = .label
        }
        
    }
    
    func coloredKeyBoard(buttons: [UIButton], color: UIColor){
        buttons.forEach{button in button.backgroundColor = color}
    }
}
