//
//  IpadPrintBatchViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 25/03/21.
//

import UIKit

class IpadPrintBatchViewController: UITableViewController {
    
    
    
    init(){
        super.init(style: .grouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var totalRecordCount : Int = 450
    
    var printSettings:PrintOptionModel = PrintOptionModel()
    
    var batchs:[PrintBatchModel] = [PrintBatchModel(from: 1, to: 500),PrintBatchModel(from: 1, to: 500)]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerReusableCell(PrintBatchCell.self)
        tableView.allowsSelection = false
        self.navigationItem.title = "Print"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(cancel))

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return batchs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as PrintBatchCell
        
        let batchItem = batchs[indexPath.row]
        
        cell.titleLabel.text = "Batch \((indexPath.row + 1))"
        cell.subTitleLabel.text = "\(batchItem.from) to \(batchItem.to) records"

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return  60
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let returnedView = UILabel()
        returnedView.backgroundColor = UIColor.clear
        
        let label = UILabel()
        label.numberOfLines = 50
        label.backgroundColor = .clear
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.black.withAlphaComponent(0.6)
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(NSAttributedString(string: "There are "))
        
        let attrbString = NSAttributedString(string: "\(totalRecordCount) records", attributes: [NSAttributedString.Key.font :UIFont.systemFont(ofSize: 14, weight: .bold)])
        attributedString.append(attrbString)
        
        attributedString.append(NSAttributedString(string: " found in this report, you can print only 500 records at a time in batches due to print limit, Please print one by one."))
        
        
        label.attributedText = attributedString
        returnedView.addSubview(label)
        
        NSLayoutConstraint.activate([label.topAnchor.constraint(equalTo: returnedView.topAnchor,constant: 10),
                                     label.leadingAnchor.constraint(equalTo: returnedView.leadingAnchor,constant: 20),
                                     label.bottomAnchor.constraint(equalTo: returnedView.bottomAnchor,constant: -10),
                                     label.trailingAnchor.constraint(equalTo: returnedView.trailingAnchor,constant: -37),
                                     
        
        ])
        
        return returnedView
    }
    
    @objc private func cancel(){
        
        self.dismiss(animated: true, completion: nil)
        
    }

}
