//
//  TownViewController.swift
//  weather
//
//  Created Z on 6/11/19.
//  Copyright © 2019 Zyma. All rights reserved.
//
//  Template generated by Juanpe Catalán @JuanpeCMiOS
//

import UIKit

class TownViewController: UIViewController, TownViewProtocol {
	var presenter: TownPresenterProtocol?
    let townCell = "TableViewCell"   // "TownTableViewCell"
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var townTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var townTableView: UITableView!
    
    @IBAction func townTextFieldEdit(_ sender: UITextField) {
        presenter?.choiceTown(townName: sender.text)
    }
    
    @IBAction func addButtonAction(_ sender: UIButton) {
        presenter?.addTown(townName: townTextField.text)
        self.indicator.startAnimating()
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.townTextField.layer.cornerRadius = 10
        self.townTextField.delegate = self
        townTableView.register(UINib(nibName: townCell, bundle: nil), forCellReuseIdentifier: townCell)
        TownRouter.createModule(view: self)
    }
    
    func update() {
        DispatchQueue.main.async {
            self.townTableView.reloadData()
            let sectionIndex = IndexSet(integer: 0)
            self.townTableView.reloadSections(sectionIndex, with: .none)
            self.indicator.stopAnimating()
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
            self.indicator.stopAnimating()
            self.showMessage(title: "ERROR", text: text) { () in
            }
        }
    }
}

extension TownViewController:  UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = presenter?.count() ?? 0
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: townCell, for: indexPath)
        if let cell = cell as? TableViewCell {
            self.createCell(cell: cell, indexPath: indexPath)
        }
        return cell
    }
    
    func createCell(cell: TableViewCell, indexPath: IndexPath) {
            cell.townTableViewCellDelegate = self
            let presenter = TablePresenterCell()
            cell.presenter = presenter
            cell.presenter?.indexCell = indexPath.row
            let (town, info, infoFull) = self.presenter?.getTextTownInfo(index: indexPath.row) ?? ("", "", "")
            let type = self.presenter?.getTypeTownInfo(index: indexPath.row) ?? false
            cell.nameLabel.text = town
            cell.temprLabel.text = info
            cell.infoLabel.text = infoFull
            if type {
                cell.infoLabel.text = infoFull + "\nClick for clouse info"
            }
            else {
                cell.infoLabel.text = "Click for open info"
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
    }
}

extension TownViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.actionChangeCell(index: indexPath.row)
    }
}

extension TownViewController: TownTableViewCellDelegate {
    func getIndex(index: Int?) {
        guard let index = index else { return }
        presenter?.showWeatherView(indexCell: index)
    }
}

extension TownViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
}
