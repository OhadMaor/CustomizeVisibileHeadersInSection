//
//  VisibleHeadersTableController.swift
//  VisibileHeadersInSection
//
//  Created by Ohad Maor on 05/08/2017.
//  Copyright (c) 2017 Ohad Maor. All rights reserved.
//

import UIKit

class VisibleHeadersTableController : NSObject, UITableViewDelegate, UITableViewDataSource {
//  MARK: - Class members
    fileprivate var dataVisibleHeadersController    : VisibleHeadersDataController
    fileprivate var visibleHeaders                  = [VisibleHeaderMetadata]()
    
  //  MARK: - Constructors
    init(viewController : BaseAsyncProtocol) {
        dataVisibleHeadersController = VisibleHeadersDataController(viewController : viewController)
    }
}

//  MARK: - Table datasource & delegate
extension VisibleHeadersTableController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataVisibleHeadersController.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataVisibleHeadersController.rowCount(for: section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {return nil}
        guard let item = dataVisibleHeadersController.getObject(at: section) as? HeaderProtocol else {return nil}
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: HeaderView.identifier) as? HeaderView else {return nil}
        bindHeader(header: header, with: item)
        return header
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell,
            let object = dataVisibleHeadersController.getObject(at: indexPath)
        else { return UITableViewCell() }
        
        bindCell(cell: cell, with: object)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {return 0}
        return 44
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int)
    {
        addVisibleHeaderIfPossible(for: view, in: section)
    }
    
    func tableView(_ tableView: UITableView, didEndDisplayingHeaderView view: UIView, forSection section: Int)
    {
        removeVisibleHeaderIfPossible(for: view)
    }
    
//  MARK: - Binding
    private func bindHeader(header : HeaderView, with object : Any?) {
        guard let object = object as? HeaderViewModel else {return}
        header.simpleLabel.text = object.titleValue
        header.changeColorForDequeue(colorState: object.colorState)
    }
    
    private func bindCell(cell : TableViewCell, with object : Any?) {
        guard let object = object as? CellViewModel else {return}
        cell.randomLabel.text = object.titleValue
    }
}

//  MARK: - Visible headers color changing
extension VisibleHeadersTableController {
    fileprivate func removeVisibleHeaderIfPossible(for header : UIView) {
        if let index = visibleHeaders.index(where: { $0.header === header }) {
            visibleHeaders.remove(at: index)
        }
    }
    
    fileprivate func addVisibleHeaderIfPossible(for header : UIView, in section : Int) {
        guard let header = header as? HeaderColorChange else {return}
        
        dataVisibleHeadersController.updateYPoition(forSection: section, position: header.frame.origin.y)
        visibleHeaders.append(VisibleHeaderMetadata(section: section, header: header))
    }
}

//  MARK: - Scroll view delegate
extension VisibleHeadersTableController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        handleColorChangingForVisibleHeaders()
    }
    
    fileprivate func handleColorChangingForVisibleHeaders() {
        for headerMetadata in visibleHeaders {
            guard let object = dataVisibleHeadersController.getObject(at: headerMetadata.section) as? ColorChangeable else {continue}
            
            if headerMetadata.isHeaderReachedStickyPosition(for: object.originalYPosition) {
                headerMetadata.header.changeColorToStickyState(colorState: object.colorState)
                dataVisibleHeadersController.changeColorState(for: headerMetadata.section, state: .sticky)
            }
            else if headerMetadata.isHeaderFloating(for: object.originalYPosition) {
                dataVisibleHeadersController.changeColorState(for: headerMetadata.section, state: .floating)
                headerMetadata.header.changeColorToFloatingState()
            }
        }
    }
}
