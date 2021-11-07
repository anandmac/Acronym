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
        static let cellIdentifier = "VariationCell"
        static let navigationBarTitle = "Variations"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavigationBar()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func setUpNavigationBar() {
        title = Constants.navigationBarTitle
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
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
        viewModel.numberOfVariations
    }
}
