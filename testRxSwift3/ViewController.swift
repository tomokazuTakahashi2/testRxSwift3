//
//  ViewController.swift
//  testRxSwift3
//
//  Created by Raphael on 2020/09/13.
//  Copyright © 2020 takahashi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController{

    @IBOutlet weak var tableView: UITableView!
    
    private let bag = DisposeBag()
    private let viewModel = ProductViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        bindTableView()
    }
    
    
    private func bindTableView() {
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: ProductTableViewCell.self)) { (row,item,cell) in
            cell.imageVieww?.image = UIImage(named: item.imageName)
            cell.nameLabel?.text = item.name
            cell.priceLabel?.text = "¥\(item.price)"
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(Product.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.name)")
        }).disposed(by: bag)
        
        viewModel.fetchProductList()
    }

}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
