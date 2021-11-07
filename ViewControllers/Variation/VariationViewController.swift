//
//  VariationViewController.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/6/21.
//

import UIKit

class VariationViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var inputModel: VariationViewInputModel!
    
    private lazy var viewModel = VariationViewModel(variations: inputModel.variations)
    
    struct Constants {
        static let cellIdentifier: String = "VariationCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
}

// MARK: UITableViewDataSource
extension VariationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.variationName(for: indexPath.row)
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfVariations
    }
}
