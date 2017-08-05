//
//  ColorChangeable.swift
//  VisibileHeadersInSection
//
//  Created by Ohad Maor on 05/08/2017.
//  Copyright © 2017 Ohad Maor. All rights reserved.
//

import Foundation

import UIKit

enum ColorState {
    case sticky
    case floating
}

protocol ColorChangeable {
    var colorState          : ColorState {get set}
    var originalYPosition   : CGFloat {get set}
}

extension ColorChangeable {
    mutating func changeYPosition(position : CGFloat)
    {
        if originalYPosition == -1
        {
            originalYPosition = position
        }
    }
}
