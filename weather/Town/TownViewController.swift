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
        TownRouter.createModule(view: self)
        townTableView.register(UINib(nibName: townCell, bundle: nil), forCellReuseIdentifier: townCell)
        //townTableView.estimatedRowHeight = 100
        //townTableView.rowHeight = UITableView.automaticDimension
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
        

        let cell = tableView.dequeueReusableCell(withIdentifier: townCell, for: indexPath) as! TableViewCell
        cell.nameLabel.text = "TEST TEST"
        
        // self.createCell(viewCell: cell, indexPath: indexPath)
        return cell
    }
    
    func createCell(viewCell: UITableViewCell, indexPath: IndexPath) {
        if let cell = viewCell as? TownTableViewCell {
            cell.townTableViewCellDelegate = self
            let presenter = TownTablePresenterCell()
            cell.presenter = presenter
            cell.presenter?.indexCell = indexPath.row
            let (town, info, infoFull) = self.presenter?.getTextTownInfo(index: indexPath.row) ?? ("", "", "")
            let type = self.presenter?.getTypeTownInfo(index: indexPath.row) ?? false
            if type {
                cell.openButton.backgroundColor = .red
                cell.tawnLabel.text = town + " " + info + " " + infoFull
            }
            else {
                cell.openButton.backgroundColor = .green
                cell.tawnLabel.text = town + " " + info
            }
            let height = 8.0 + cell.tawnLabel.frame.height + 100.0
            cell.frame = CGRect(x: 0, y: 0, width: cell.frame.size.width, height: height)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
        }
    }
}

extension TownViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showWeatherView(indexCell: indexPath.row)
    }
}

extension TownViewController: TownTableViewCellDelegate {
    func getIndex(index: Int?) {
        presenter?.actionCellButton(index: index)
    }
}
