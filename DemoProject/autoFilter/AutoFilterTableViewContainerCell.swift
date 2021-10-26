//
//  AutoFilterTableViewContainerCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 25/10/21.
//

import UIKit

class AutoFilterTableViewContainerCell:UITableViewCell {
    
    var cellModel:AutoFilterModel?
    
    var updataModelToMainModel:(AutoFilterModel) -> Void = {_ in}
    
    private lazy var tableViewHeightConstraint:NSLayoutConstraint = NSLayoutConstraint()
    
    lazy var tableView: UITableView = {
        var tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.register(AutoFilterSelectionCell.self, forCellReuseIdentifier: "AutoFilterSelectionCell")
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
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoFilterSelectionCell") as? AutoFilterSelectionCell else{ return UITableViewCell() }
        
        let optionCellModel = returnCellModel(dataSource: dataSource, forRow: indexPath.row)
        
        cell.configure(optionCellModel)
//        cell.textLabel?.text = dataSource.filterValues[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard var dataSource = self.cellModel else{ return }
        
        dataSource.filterValues[indexPath.row].isSelected = !dataSource.filterValues[indexPath.row].isSelected
        
        self.cellModel = dataSource
        
        self.tableView.reloadData()
        
        updataModelToMainModel(dataSource)
    }
    
    
    private func returnCellModel(dataSource:AutoFilterModel,forRow index:Int) -> ColumnSelectionCellModel{
        
        var sholudHideSeperator:Bool = false
        if index == (dataSource.filterValues.count - 1){
            sholudHideSeperator = true
        }
        
        return ColumnSelectionCellModel.init(displayText: dataSource.filterValues[index].displaytext, isSelected: dataSource.filterValues[index].isSelected, sholudHideSeperator: sholudHideSeperator)
    }
    
    
}

extension AutoFilterTableViewContainerCell{
    
    private func setUpView(){
        self.selectionStyle = .none
        self.contentView.addSubview(tableView)
        
        tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -15),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            tableViewHeightConstraint
        ])
        
    }
    
    private func updateHeightConstrintForTableView(){
        guard let dataSource = self.cellModel else{ return}
        
        let height:Int
        
        let tableViewHeight = dataSource.filterValues.count * 56
        
        if tableViewHeight >= 280 {
            height = 280
        }else{
            height = tableViewHeight
        }
        
        tableViewHeightConstraint.constant = CGFloat(height)

    }
    
}

class AutoFilterSelectionCell:ColumnSelectionCell{
    
    
}
