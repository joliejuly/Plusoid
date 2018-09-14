//
//  ViewController.swift
//  StorePrices
//
//  Created by Julia Nikitina on 14/09/2018.
//  Copyright © 2018 Julia Nikitina. All rights reserved.
//

import UIKit

final class AddItemsViewController: UIViewController {

    var prices = [Int]()
    
    var sum = 0 {
        didSet {
            sumLabel.text = "Итого: \(sum) ₽"
        }
    }
    
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sumLabel: UILabel!
    
    //MARK: - Side menu
    @IBOutlet weak var leadingContainerViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var trailingContainerViewConstraint: NSLayoutConstraint!
    
    
    @IBAction func swipeOccured(_ sender: UISwipeGestureRecognizer) {
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.leadingContainerViewConstraint.constant = 150
            self?.trailingContainerViewConstraint.constant = -150
            self?.view.layoutIfNeeded()
        }
        
        view.endEditing(true)
    }
    
    @IBAction func doubleTapOccured(_ sender: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.4) { [weak self] in
            self?.leadingContainerViewConstraint.constant = 0
            self?.trailingContainerViewConstraint.constant = 0
            self?.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
       
    }

    //MARK: - Actions
    @IBAction func addButtonTapped(_ sender: UIButton) {
        proceed(textFieldInput: priceTextField.text)
        priceTextField.resignFirstResponder()
        priceTextField.text = ""
    }
    
    //MARK: - Helpers
    
    private func proceed(textFieldInput: String?) {
        guard
            let text = textFieldInput,
            !text.isEmpty,
            let number = Int(text)
        else { return }
        
        prices.insert(number, at: 0)
        tableView.reloadData()
        updateSum()
    }
    
    private func updateSum() {
        sum = prices.reduce(0, +)
    }
    
}

//MARK: - Table view data source methods
extension AddItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "priceCell", for: indexPath)
        
        if indexPath.row < prices.count {
            cell.textLabel?.text = "\(prices[indexPath.row]) ₽"
        }
        
        return cell
    }
    
}

//MARK: - Table view delegate methods
extension AddItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            prices.remove(at: indexPath.row)
            updateSum()
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    
}
