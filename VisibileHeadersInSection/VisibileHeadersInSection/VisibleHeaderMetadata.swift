//
//  VisibleHeaderMetadata.swift
//  VisibileHeadersInSection
//
//  Created by Ohad Maor on 05/08/2017.
//  Copyright © 2017 Ohad Maor. All rights reserved.
//

import UIKit

struct VisibleHeaderMetadata {
    let section             : Int
    let header              : HeaderColorChange
    
    func isHeaderReachedStickyPosition(for staticYPosition : CGFloat) -> Bool {
        return header.frame.origin.y > staticYPosition
    }
    
    func isHeaderFloating(for staticYPosition : CGFloat) -> Bool {
        return header.frame.origin.y <= staticYPosition
    }
}
