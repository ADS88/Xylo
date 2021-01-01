//
//  GameModeOptionView.swift
//  Xylophone
//
//  Created by Andrew on 1/01/21.
//

import UIKit

class GameModeOptionView: UIView {

    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var optionTitle: UILabel!
    @IBOutlet weak var optionDescription: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let viewFromXib : UIView = Bundle.main.loadNibNamed("GameModeOptionView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
}
