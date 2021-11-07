//
//  AcronymsViewController.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/6/21.
//

import UIKit

class AcronymsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView?
    
    private lazy var viewModel = AcronymsViewModel()
    private lazy var router = AcronymsRouter(viewController: self)
    
    struct Constants {
        static let cellIdentifier = "AcronymsCell"
        static let nibName = "AcronymsCell"
        static let okButtonTitle = "OK"
        static let validationErrorText = "Please enter valid text"
        static let navigationBarTitle = "Acronyms"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = Constants.navigationBarTitle
        configureTableView()
    }
    
    // to hide keyboard when tap on table view
    @IBAction func tapOnTableView() {
        textField.resignFirstResponder()
    }
    
    private func configureTableView() {
        tableView.register(UINib(nibName: Constants.nibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    private func getAcronyms(for text: String) {
        activityIndicatorView?.startAnimating()
        viewModel.getAcronyms(searchText: text) { [weak self] (error) in
            self?.activityIndicatorView?.stopAnimating()
            if let error = error {
                switch error {
                case AcronymsAPIError.noAcronyms:
                    self?.showErrorAlert(text: "There is no Acronyms for \"\(text)\" please try some other text")
                default:
                    #if DEBUG
                    print(error.localizedDescription)
                    #endif
                    return
                }
            } else {
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    private func showErrorAlert(text: String) {
        // create the alert
        let alert = UIAlertController(title: text, message: nil, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.okButtonTitle, style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: UITextFieldDelegate
extension AcronymsViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField : UITextField) {
       textField.autocorrectionType = .no
       textField.autocapitalizationType = .none
       textField.spellCheckingType = .no
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        
        if let text = textField.text, !text.isEmpty {
            viewModel.isValidString(text: text) ? getAcronyms(for: text) : showErrorAlert(text: Constants.validationErrorText)
        }
        
        return true
    }
}

// MARK: UITableViewDataSource
extension AcronymsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as? AcronymsCell else {
            return UITableViewCell()
        }
        let item = viewModel.item(for: indexPath.row)
        listCell.configure(title: item.title, count: item.variationCount)
        
        listCell.variationHandler = { [weak self] in
            if let variations = self?.viewModel.variations(for: indexPath.row) {
                self?.router.showVariationView(variations: variations)
            }
        }
        
        return listCell
   }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfAcronyms
    }
}
