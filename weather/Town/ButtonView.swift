//
//  ButtonView.swift
//  weather
//
//  Created by Z on 7/6/19.
//  Copyright © 2019 Zyma. All rights reserved.
//

import UIKit

class ButtonView: UIButton {
        override func awakeFromNib() {
            super.awakeFromNib()
            self.layer.cornerRadius = 10
        }
}
