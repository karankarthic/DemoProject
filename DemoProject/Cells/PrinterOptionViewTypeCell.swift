//
//  PrinterOptionViewTypeCell.swift
//  DemoProject
//
//  Created by Karan Karthic Neelamegan on 08/04/21.
//

import UIKit

protocol PrinterOptionViewTypeCellDelegate:class {
    func updatePrinterOptionViewTypeValue(viewType:String)
}

class PrinterOptionViewTypeCell:UITableViewCell{
    
    weak var delegate:PrinterOptionViewTypeCellDelegate?
    
    private lazy var segmentView: UISegmentedControl = {
        
        var items = ["List View","Detail View"]
        
        let segmentView = UISegmentedControl(items: items)
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        segmentView.selectedSegmentIndex = 0
        segmentView.tintColor = UIColor.black
        segmentView.addTarget(self, action: #selector(segmentedControlValueChanged(_:)), for: .touchUpInside)
        if #available(iOS 13.0, *) {
            segmentView.setTitleTextAttributes([NSAttributedString.Key.backgroundColor: UIColor.white], for: .normal)
            segmentView.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)
        } else {}
        return segmentView
    }()
    
    private lazy var titleLabel: UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.text = "View Type"
        titleLabel.textAlignment = .left
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.font = .systemFont(ofSize: 17, weight: .bold)
        titleLabel.backgroundColor = .clear
        return titleLabel
    }()
    
    private lazy var verticalStackView:UIStackView = {
        let vStack = UIStackView()
        vStack.translatesAutoresizingMaskIntoConstraints = false
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .equalSpacing
        vStack.spacing = 17
        return vStack
        
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCellView()
        
    }
    
    private func setupCellView() {
        
        self.contentView.addSubview(verticalStackView)
    
        if UIDevice.current.userInterfaceIdiom == .phone {
            verticalStackView.addArrangedSubview(titleLabel)
        }
        
        verticalStackView.addArrangedSubview(segmentView)
        
        NSLayoutConstraint.activate([
        
            verticalStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 19),
            verticalStackView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 19),
            verticalStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -19),
            verticalStackView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -19)
            ])
        delegate?.updatePrinterOptionViewTypeValue(viewType: "List View")
    }
    
    @objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            delegate?.updatePrinterOptionViewTypeValue(viewType: "List View")
        }else{
            delegate?.updatePrinterOptionViewTypeValue(viewType: "Detail View")
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
