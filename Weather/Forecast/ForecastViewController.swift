//
//  ForecastViewController.swift
//  weather
//
//  Created Z on 6/11/19.
//  Copyright © 2019 Zyma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class ForecastViewController: UIViewController, ForecastViewProtocol {
	var presenter: ForecastPresenterProtocol?
    
    @IBOutlet weak var forecastTableView: UITableView!
    @IBOutlet weak var tatleLabel: UILabel!
    
	override func viewDidLoad() {
        super.viewDidLoad()
        tatleLabel.text = presenter?.getTitle()
        presenter?.loadData()
    }

    func update() {
        DispatchQueue.main.async {
            self.forecastTableView.reloadData()
            let sectionIndex = IndexSet(integer: 0)
            self.forecastTableView.reloadSections(sectionIndex, with: .none)
        }
    }
    
    func showMessage(title: String, text: String, action repeatHandler: @escaping ()->()) {
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            repeatHandler()
        }
        let controller = UIAlertController(title: title, message: text, preferredStyle: .alert)
        controller.addAction(alertAction)
        
        DispatchQueue.main.async {
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func showError(text: String) {
        DispatchQueue.main.async {
            // self.indicator.stopAnimating()
            self.showMessage(title: "ERROR", text: text) { () in
                
            }
        }
    }
}

extension ForecastViewController:  UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.count() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ForecastTableViewCell", for: indexPath)

        if let cell = cell as? ForecastTableViewCellProtocol {
            let text = presenter?.getForecastInfo(index: indexPath.row) ?? ""
            cell.configCell(text: text)
        }
        return cell
    }
}

extension ForecastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}