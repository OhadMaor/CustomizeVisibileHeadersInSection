//
//  HeaderViewModel.swift
//  VisibileHeadersInSection
//
//  Created by Ohad Maor on 05/08/2017.
//  Copyright (c) 2017 Ohad Maor. All rights reserved.
//

import UIKit

protocol HeaderProtocol {
    var cellViewModels  : [CellViewModel] {get set}
    var titleValue      : String        {get set}
}

struct HeaderViewModel : HeaderProtocol, ColorChangeable {
//  MARK: Class members
    var cellViewModels   : [CellViewModel]
    var titleValue       : String
    
    //  ColorChangeable
    var colorState          : ColorState = .floating
    var originalYPosition   : CGFloat = -1
    
//  MARK: - Constructors
    init(titleValue : String) {
        self.titleValue = titleValue
        cellViewModels = []
        
        for i in 0...5 {
            let cellViewModel = CellViewModel(titleValue: String(i))
            cellViewModels.append(cellViewModel)
        }
    }
}


