//
//  HeaderColorChange.swift
//  VisibileHeadersInSection
//
//  Created by Ohad Maor on 05/08/2017.
//  Copyright © 2017 Ohad Maor. All rights reserved.
//

import UIKit

class HeaderColorChange : UITableViewHeaderFooterView {
    @IBOutlet weak var containerView: UIView!
    
    //  MARK: - Color changing
    //  MARK: - Public
    func changeColorToFloatingState() {
        containerView.backgroundColor = backgroundDefault
    }
    
    /// - Parameter colorState: if colorState isn't sticky,
    /// a first alpha color with 0.1 will be given else,
    /// we will add 0.1 every invoke iteration
    func changeColorToStickyState(colorState : ColorState) {
        let isIterating = (colorState == .sticky ? true : false)
        changeColorToStickyState(isIterating: isIterating)
    }
    
    func changeColorForDequeue(colorState : ColorState) {
        switch colorState {
        case .floating:
            changeColorToFloatingState()
            
        case .sticky:
            containerView.backgroundColor = finalBackgroundChange
        }
    }
    
//  MARK: - Private
    private func changeColorToStickyState(isIterating : Bool) {
        let backgroundColor = isIterating ? iterativeBackgroundChange : backgroundChange
        containerView.backgroundColor = backgroundColor
    }
}

//  MARK: - Colors
extension HeaderColorChange {
    var backgroundDefault : UIColor {
        return UIColor.white
    }
    
    var backgroundChange : UIColor {
        return UIColor(red: 0.066172,
                       green: 0.764687,
                       blue: 0.867587,
                       alpha: 0.1)
    }
    
    var finalBackgroundChange : UIColor {
        return UIColor(red: 0.066172,
                       green: 0.764687,
                       blue: 0.867587,
                       alpha: 1)
    }
    
    var iterativeBackgroundChange : UIColor {
        if let oldColor = containerView.backgroundColor {
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
            oldColor.getRed(&r, green: &g, blue: &b, alpha: &a)
            return UIColor(colorLiteralRed: Float(r),
                           green: Float(g),
                           blue: Float(b),
                           alpha: Float(a + 0.1))
        }
        return backgroundChange
    }
}
