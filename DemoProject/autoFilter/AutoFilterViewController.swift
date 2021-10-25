//
//  AutoFilterViewController.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 21/10/21.
//

import UIKit

class AutoFilterViewController:CardLayoutTableViewController{
    
    var presenter:AutoFilterViewToPresenterProtocol?
    
    var dataSource:AutoFilterDataSource? = nil
    
    override var tableViewEdgeInset: UIEdgeInsets {
        .init(top: (UIApplication.shared.statusBarFrame.size.height + 22), left: 11, bottom: 0, right: -11)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.register(AutoFilterTableViewContainerCell.self, forCellReuseIdentifier: "AutoFilterTableViewContainerCell")
    }
    
}

extension AutoFilterViewController{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 270
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource?.numberOfSections ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource?.getNumberOfRows(forSection: section) ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dataSource = self.dataSource else{ return UITableViewCell() }
        
//        let cell = UITableViewCell()
//
//        cell.textLabel?.text = dataSource.cellModel(forIndexpath: indexPath)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AutoFilterTableViewContainerCell") as? AutoFilterTableViewContainerCell  else{ return UITableViewCell() }
        cell.configureView(withModel: dataSource.dataSourceModel[indexPath.section])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let title = dataSource?.returnSectionTitle(forSection: section)
        let uiView = constructHeaderForSections(title: title ?? "", section: section)
        return uiView
        
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let viewConstructor = CornerViewConstructor.init(contentView: cell.contentView)
            viewConstructor.constructLayout(for: .bottomCorner)
    }
    
    
}

extension AutoFilterViewController:AutoFilterPresenterToViewProtocol{
    
    func reloadUi(dataSource:AutoFilterDataSource) {
        
        self.dataSource = dataSource
        
        self.tableView.reloadData()
        
    }
}

extension AutoFilterViewController{
    
    private func constructHeaderForSections(title:String,section:Int) -> UIView{
        let uiView = UIView()
        uiView.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.text = title
        //        if self.view.isRightToLeft{
        //            titleLabel.textAlignment = .right
        //        }else{
        //            titleLabel.textAlignment = .left
        //        }
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.backgroundColor = .clear
        
        var iconView : UIImageView = {
            let iconView = UIImageView()
            iconView.tintColor = .black
            iconView.translatesAutoresizingMaskIntoConstraints = false
            iconView.widthAnchor.constraint(equalToConstant: 22).isActive = true
            iconView.heightAnchor.constraint(equalToConstant: 22).isActive = true
            //            iconView.isHidden = true
            iconView.isUserInteractionEnabled = true
            return iconView
        }()
        
        var selectCountLable : UILabel = {
            let selectCountLable = UILabel()
            selectCountLable.text = "0"
            selectCountLable.textAlignment = .center
            selectCountLable.isHidden = true
            selectCountLable.translatesAutoresizingMaskIntoConstraints = false
            selectCountLable.widthAnchor.constraint(equalToConstant: 22).isActive = true
            selectCountLable.heightAnchor.constraint(equalToConstant: 22).isActive = true
            selectCountLable.layer.cornerRadius = 11
            selectCountLable.clipsToBounds = true
            selectCountLable.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            return selectCountLable
        }()
        
        uiView.addSubview(titleLabel)
        uiView.addSubview(iconView)
        uiView.addSubview(selectCountLable)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: uiView.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: uiView.leadingAnchor, constant: 19),
            titleLabel.bottomAnchor.constraint(equalTo: uiView.bottomAnchor, constant: 0),
            titleLabel.trailingAnchor.constraint(equalTo: uiView.trailingAnchor, constant: -19),
            
            iconView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            iconView.bottomAnchor.constraint(equalTo: uiView.bottomAnchor, constant: -18),
            iconView.trailingAnchor.constraint(equalTo: uiView.trailingAnchor,constant: -20),
            
            selectCountLable.bottomAnchor.constraint(equalTo: uiView.bottomAnchor, constant: -18),
            selectCountLable.trailingAnchor.constraint(equalTo: uiView.trailingAnchor,constant: -20),
            
        ])
        
        
        let viewConstructor = CornerViewConstructor.init(contentView: uiView)
        
        if (dataSource?.isItInCollapsedState(forSection: section) ?? false){
            viewConstructor.constructLayout(for: .allCorner)
            iconView.image = UIImage.init(named: "Image-1")?.withRenderingMode(.alwaysTemplate)
        }else{
            viewConstructor.constructLayout(for: .topCorner)
            iconView.image = UIImage.init(named: "Image")?.withRenderingMode(.alwaysTemplate)
        }
        uiView.tag = section
        
        uiView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(getFilterValues(gesture:))))
        
        return uiView
    }
    
    @objc private func getFilterValues(gesture: UITapGestureRecognizer){
        
        guard let section = gesture.view?.tag  else {
            return
        }
        
        
        presenter?.fetchFilterValuesForOption(section: section)
        
    }
}

