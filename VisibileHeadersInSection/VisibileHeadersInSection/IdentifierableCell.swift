//
//  IdentifierableCell.swift
//  VisibileHeadersInSection
//
//  Created by Ohad Maor on 05/08/2017.
//  Copyright © 2017 Ohad Maor. All rights reserved.
//

import UIKit

protocol IdentifierableCell {
    static var nib          : UINib {get}
    static var identifier   : String {get}
}

extension IdentifierableCell where Self : UIView {
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
