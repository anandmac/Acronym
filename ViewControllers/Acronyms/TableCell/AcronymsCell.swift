//
//  AcronymsCell.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/6/21.
//

import Foundation
import UIKit

class AcronymsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var variationButton: UIButton!
    
    var variationHandler: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        titleLabel.text = nil
    }
    
    func configure(title: String, count: Int) {
        titleLabel.text = title
        variationButton.setTitle(String(count), for: .normal)
    }
    
    @IBAction func didTapVariation(_ sender: Any) {
        variationHandler?()
    }
}
