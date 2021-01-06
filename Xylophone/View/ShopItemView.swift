//
//  ShopItemView.swift
//  Xylophone
//
//  Created by Andrew on 6/01/21.
//

import UIKit

class ShopItemView: UIView {

    @IBOutlet weak var shopItemImage: UIImageView!
    @IBOutlet weak var shopItemTitle: UILabel!
    @IBOutlet weak var shopItemButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit(){
        let viewFromXib : UIView = Bundle.main.loadNibNamed("ShopItemView", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
}

