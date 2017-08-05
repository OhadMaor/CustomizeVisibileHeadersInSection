//
//  VisibleHeadersDataController.swift
//  VisibileHeadersInSection
//
//  Created by Ohad Maor on 05/08/2017.
//  Copyright (c) 2017 Ohad Maor. All rights reserved.
//

import UIKit

class VisibleHeadersDataController {
//  MARK: - Class members
    private var array : [HeaderProtocol]
    
    func changeColorState(for section: Int, state: ColorState) {
        guard var object = array[section] as? ColorChangeable else {return}
        object.colorState = state
        array[section] = object as! HeaderProtocol
    }
    
    private weak var delegateToViewController : BaseAsyncProtocol?
  
//  MARK: - Constructors
    required init(viewController : BaseAsyncProtocol) {
        array = []
        delegateToViewController = viewController
        fetchModels()
    }

    private func fetchModels() {
        DispatchQueue.global(qos: .background).async {
            for i in 0...15 {
                let header = HeaderViewModel(titleValue: "My awesome position is " + String(i))
                self.array.append(header)
            }
            self.delegateToViewController?.didFinish(responseType: .refreshData)            
        }
    }

//  MARK: - Public array methods
    ///  Returns the corresponding header object
    func getObject(at index : Int) -> Any? {
        if !array.isEmpty && index < array.count {
            if let model = array[index] as? HeaderViewModel {
                return model
            }
        }
        return nil
    }
    
    ///  Returns the corresponding cell object
    func getObject(at indexPath : IndexPath) -> Any? {
        if let object = getObject(at: indexPath.section) as? HeaderProtocol {
            if !object.cellViewModels.isEmpty && indexPath.row < object.cellViewModels.count {
                return object.cellViewModels[indexPath.row]
            }
        }
        return nil
    }
    
    var count: Int {
        get {
            return array.count
        }
    }
    
    func rowCount(for index : Int) -> Int {
        if !array.isEmpty && index < array.count {
            return array[index].cellViewModels.count
        }
        return 0
    }
    
    /// Objects must conform to ColorChangeable
    func updateYPoition(forSection section: Int, position : CGFloat) {
        guard var object = array[section] as? ColorChangeable else {return}
        object.changeYPosition(position: position)
        array[section] = object as! HeaderProtocol
    }
}
