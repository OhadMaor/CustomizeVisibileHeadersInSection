//
//  VisibleHeadersViewController.swift
//  VisibileHeadersInSection
//
//  Created by Ohad Maor on 05/08/2017.
//  Copyright (c) 2017 Ohad Maor. All rights reserved.
//

import UIKit

class VisibleHeadersViewController : UIViewController, BaseAsyncProtocol
{
// MARK: - Properties
    private var tableVisibleHeadersController : VisibleHeadersTableController!
    @IBOutlet weak var tableView: UITableView!
  
// MARK: - View Controller lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainSetup()
    }
  
// MARK: - Private methods: Event handling
    fileprivate func mainSetup() {
        setupOutlets()
        tableView.register(TableViewCell.nib, forCellReuseIdentifier: TableViewCell.identifier)
        tableView.register(HeaderView.nib, forHeaderFooterViewReuseIdentifier: HeaderView.identifier)
    }

    fileprivate func setupOutlets() {
        bindTableController()
    }

    fileprivate func bindTableController() {
        tableVisibleHeadersController = VisibleHeadersTableController(viewController : self)
        tableView.dataSource = tableVisibleHeadersController
        tableView.delegate = tableVisibleHeadersController
    }

// MARK: - BaseAsyncProtocol override
    func didFinish(responseType: BaseGeneralResponse.CommonType?) {
        guard let responseType = responseType else { return }

        DispatchQueue.main.async {
                switch responseType
                {
                case .refreshData:
                    self.tableView.reloadData()
                    
                case .noData:
                    break
                }
            }
    }
}
