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
        case "Black Keyboard":
            coloredKeyBoard(buttons: buttons, color: .black)
        case "Gold Keyboard":
            coloredKeyBoard(buttons: buttons, color: #colorLiteral(red: 1, green: 0.8431372549, blue: 0, alpha: 1))
        case "Invisible Keyboard":
            invisibleKeys(buttons: buttons)
        case "Pretty Pink Keyboard":
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
