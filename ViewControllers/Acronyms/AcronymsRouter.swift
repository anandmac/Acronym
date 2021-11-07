//
//  AcronymsRouter.swift
//  Acronym
//
//  Created by Praveen, Anand on 11/7/21.
//

import UIKit

struct AcronymsRouter {
    
    weak var viewController: UIViewController?
    
    func showVariationView(variations: [String]) {
        guard let viewController = viewController else {
            return
        }
       
        let inputModel = VariationViewInputModel(variations: variations)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        if let variationViewController = storyBoard.instantiateViewController(withIdentifier: "VariationViewController") as? VariationViewController {
            variationViewController.inputModel = inputModel
            let navigationController = UINavigationController(rootViewController: variationViewController)
            viewController.present(navigationController, animated:true, completion:nil)
        }
    }
}
