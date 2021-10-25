//
//  AutoFilterTableViewContainerCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 25/10/21.
//

import UIKit

class AutoFilterTableViewContainerCell:UITableViewCell {
    
    var cellModel:AutoFilterModel?
    
    private lazy var tableViewHeightConstraint:NSLayoutConstraint = NSLayoutConstraint()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        return tableView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    
    func configureView(withModel model:AutoFilterModel){
        self.cellModel = model
        if model.filterValues.count > 5{
            self.tableView.isScrollEnabled = true
        }else{
            self.tableView.isScrollEnabled = false
        }
        self.tableView.reloadData()
        updateHeightConstrintForTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AutoFilterTableViewContainerCell: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cellModel = self.cellModel else{
            return 0
        }
        
        return cellModel.filterValues.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = self.cellModel else{ return UITableViewCell() }
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.textLabel?.text = dataSource.filterValues[indexPath.row]
        
        return cell
    }
    
    
}

extension AutoFilterTableViewContainerCell{
    
    private func setUpView(){
        self.selectionStyle = .none
        self.contentView.addSubview(tableView)
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            tableViewHeightConstraint
        ])
        
    }
    
    private func updateHeightConstrintForTableView(){
        guard let dataSource = self.cellModel else{ return}
        
        let height:Int
        
        let tableViewHeight = dataSource.filterValues.count * 54
        
        if tableViewHeight >= 270 {
            height = 270
        }else{
            height = tableViewHeight
        }
        
        tableViewHeightConstraint.constant = CGFloat(height)

    }
    
}
