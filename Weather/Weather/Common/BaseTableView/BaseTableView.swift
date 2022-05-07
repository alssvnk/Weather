//
//  BaseTableView.swift
//  Weather
//
//  Created by Alisiya on 7.05.22.
//

import Foundation
import UIKit

protocol BaseCellViewModelProtocol { }

protocol BaseInputViewModelProtocol {
    var cells: [BaseCellViewModelProtocol] { get }
}

class BaseTableView: UITableView {

    var viewModel: BaseInputViewModelProtocol?

    func setup() {
        self.dataSource = self
    }
}

// MARK: - UITableViewDataSource

extension BaseTableView: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.cells.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModel = viewModel?.cells[indexPath.row] else { return UITableViewCell() }
        
        return UITableViewCell()
    }
    
}
