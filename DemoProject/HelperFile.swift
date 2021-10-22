//
//  CardLayoutCornerViewFactory.swift
//  AppBrand
//
//  Created by dhanasekaran on 15/11/18.
//  Copyright © 2018 dhanasekaran. All rights reserved.
//

import UIKit

struct CornerViewConstructor
{
    let leftTopView : UIView = CardLayoutCornerViewFactory.leftTopCornerView()
    let rightTopView : UIView = CardLayoutCornerViewFactory.rightTopCornerView()
    let leftBottomView : UIView = CardLayoutCornerViewFactory.leftBottomCornerView()
    let rightBottomView :UIView = CardLayoutCornerViewFactory.rightBottomCornerView()
    let containerView : UIView
    
    init(contentView: UIView)
    {
        self.containerView = contentView
    }
    enum CornerType
    {
        case allCorner
        case topCorner
        case bottomCorner
    }
    
    enum CornerSide
    {
        case left
        case right
    }
    
    enum CornerEdge
    {
        case top
        case bottom
    }
    
    func constructLayout(for cornerType : CornerType)
    {
        switch cornerType
        {
        case .allCorner : constructAllCorner()
        case .topCorner : constructTopCorner()
        case .bottomCorner : constructBottomCorner()
        }
    }
}
private extension CornerViewConstructor
{
    func constructTopCorner()
    {
        containerView.addSubview(leftTopView)
        containerView.addSubview(rightTopView)
        
        activateConstrinat(for: leftTopView, side: .left, edge: .top)
        activateConstrinat(for: rightTopView, side: .right, edge: .top)
    }
    
    func constructBottomCorner()
    {
        containerView.addSubview(leftBottomView)
        containerView.addSubview(rightBottomView)
        
        activateConstrinat(for: leftBottomView, side: .left, edge: .bottom)
        activateConstrinat(for: rightBottomView, side: .right, edge: .bottom)
    }
    
    func constructAllCorner()
    {
        containerView.addSubview(leftTopView)
        containerView.addSubview(rightTopView)
        containerView.addSubview(leftBottomView)
        containerView.addSubview(rightBottomView)
        
        activateConstrinat(for: leftTopView, side: .left, edge: .top)
        activateConstrinat(for: rightTopView, side: .right, edge: .top)
        activateConstrinat(for: leftBottomView, side: .left, edge: .bottom)
        activateConstrinat(for: rightBottomView, side: .right, edge: .bottom)
    }
    
    func activateConstrinat(for view : UIView , side : CornerSide , edge : CornerEdge)
    {
        var xAxisConstraint = NSLayoutConstraint()
        var yAxisConstraint = NSLayoutConstraint()
        switch side
        {
        case .left : xAxisConstraint = view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        case .right : xAxisConstraint = view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        }
        switch edge
        {
        case .top : yAxisConstraint = view.topAnchor.constraint(equalTo: containerView.topAnchor)
        case .bottom : yAxisConstraint = view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        }
        let heightConstriant = view.heightAnchor.constraint(equalToConstant: viewPadding)
        let widthConstraint = view.widthAnchor.constraint(equalToConstant: viewPadding)
        NSLayoutConstraint.activate([ xAxisConstraint , yAxisConstraint, heightConstriant , widthConstraint ])
    }
}
extension CornerViewConstructor
{
    struct CardLayoutCornerViewFactory
    {
        static func leftTopCornerView() -> UIView
        {
            let returnView = CornerView()
            returnView.updateView(with: .LeftTop)
            returnView.translatesAutoresizingMaskIntoConstraints = false
            return returnView
        }
        static func rightTopCornerView() -> UIView
        {
            let returnView = CornerView()
            returnView.updateView(with: .RightTop)
            returnView.translatesAutoresizingMaskIntoConstraints = false
            return returnView
        }
        static func leftBottomCornerView() -> UIView
        {
            let returnView = CornerView()
            returnView.updateView(with: .LeftBottom)
            returnView.translatesAutoresizingMaskIntoConstraints = false
            return returnView
        }
        static func rightBottomCornerView() -> UIView
        {
            let returnView = CornerView()
            returnView.updateView(with: .RightBottom)
            returnView.translatesAutoresizingMaskIntoConstraints = false
            return returnView
        }
    }
    
    
    var viewPadding : CGFloat {
        return 10
    }
}


class CornerView : UIView
{
    private var widthHeight : CGFloat{
        get{
            return 10
        }
    }
    private var cornerRadius : CGFloat{
        get{
            return 11
        }
    }
    
    private let maskLayer = CAShapeLayer()
    
    enum LayoutType : Int
    {
        case LeftTop = 0
        case RightTop = 1
        case LeftBottom = 2
        case RightBottom = 3
    }
    
    func updateView(with layoutType : LayoutType)
    {
        self.backgroundColor = UIColor.groupTableViewBackground
        
        let path = CGMutablePath()
        var boundWidth = CGFloat()
        var boundHeight = CGFloat()
        if layoutType == .LeftTop
        {
            boundWidth = self.bounds.origin.x + self.widthHeight
            boundHeight = self.bounds.origin.x + self.widthHeight
        }
        else if layoutType == .RightTop
        {
            boundWidth = self.bounds.origin.x
            boundHeight = self.bounds.origin.x + self.widthHeight
        }
        else if layoutType == .LeftBottom
        {
            boundWidth = self.bounds.origin.x + self.widthHeight
            boundHeight = self.bounds.origin.x
        }
        else
        {
            boundWidth = self.bounds.origin.x
            boundHeight = self.bounds.origin.x
        }
        
        
        
        path.addArc(center: CGPoint.init(x: boundWidth, y: boundHeight), radius: cornerRadius, startAngle: 0.0, endAngle: 2 * 3.14, clockwise: false)
        path.addRect(CGRect.init(x: 0, y: 0, width: self.widthHeight, height: self.widthHeight))
        
        maskLayer.backgroundColor = UIColor.green.cgColor
        maskLayer.path = path
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        self.layer.mask = maskLayer
    }
    
}

class CardLayoutTableViewController: UIViewController
{
    let tableView : UITableView = UITableView.init(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView()
    {
        view.backgroundColor = UIColor.groupTableViewBackground
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Identifier")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: tableViewEdgeInset.left),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: tableViewEdgeInset.right),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: tableViewEdgeInset.top),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: tableViewEdgeInset.bottom),
            ])
    }
    
    var tableViewEdgeInset : UIEdgeInsets {
        return .init(top: 0, left: 11, bottom: 0, right: -11)
    }
    
}

extension CardLayoutTableViewController : UITableViewDelegate
{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let viewConstructor = CornerViewConstructor.init(contentView: cell.contentView)
        if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1{
            viewConstructor.constructLayout(for: .allCorner)
        } else if indexPath.row == 0 {
            viewConstructor.constructLayout(for: .topCorner)
        } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            viewConstructor.constructLayout(for: .bottomCorner)
        }
    }
}

extension CardLayoutTableViewController : UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Identifier")!
        cell.textLabel?.text = "test"
        return cell
    }
}

extension CardLayoutTableViewController
{
    
}

protocol Reusable
{
    static var reuseIdentifier : String { get }
}

extension Reusable
{
    static var reuseIdentifier : String
    {
        return String(describing: self)
    }
}

extension UITableViewCell :  Reusable
{
    
}

extension UITableView
{
    func registerReusableCell<T: UITableViewCell>(_: T.Type)
    {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type)
    {
        self.register(T.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T
    {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T
    {
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as! T
    }
}

extension UICollectionViewCell : Reusable
{
    
}

extension UITableViewHeaderFooterView : Reusable
{
    
}

extension UIView {
    
    func addBorder(edge: UIRectEdge, color: UIColor? = UITableView().separatorColor, borderWidth: CGFloat = 0.5) {
        var borderSize = borderWidth
        if #available(iOS 10.0, *) {} else {
            borderSize = 1
        }
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(seperator)
        seperator.backgroundColor = color
        if edge == .top || edge == .bottom {
            seperator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            seperator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            seperator.heightAnchor.constraint(equalToConstant: borderSize).isActive = true
            if edge == .top {
                seperator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            }
            else {
                seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            }
        } else if edge == .left || edge == .right {
            seperator.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            seperator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
            seperator.widthAnchor.constraint(equalToConstant: borderSize).isActive = true
            if edge == .left {
                seperator.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            }
            else {
                seperator.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            }
        }
    }
    
}
