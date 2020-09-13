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
        
        //RxCocoaでTableViewをDelegate
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        //UITableViewをバインディング
        bindTableView()
    }
    
    //UITableViewのバインディング
    private func bindTableView() {
        //カスタムセル
        tableView.register(UINib(nibName: "ProductTableViewCell", bundle: nil), forCellReuseIdentifier: "cellId")
        
        //viewModel.itemsをtableViewにバインディング
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: ProductTableViewCell.self)) { (row,item,cell) in
            
            //カスタムセルのimageViewにitemのimageNameを反映する
            cell.imageVieww?.image = UIImage(named: item.imageName)
            //カスタムセルのnameLabelにitemのnameを反映する
            cell.nameLabel?.text = item.name
            //カスタムセルのpriceLabelにitemのpriceを反映する
            cell.priceLabel?.text = "¥\(item.price)"
            
        }.disposed(by: bag)
        
        //セルをタップしたら
        tableView.rx.modelSelected(Product.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.name)")
            
//            self.performSegue(withIdentifier: "vc2", sender: nil)
            
            //画面遷移
            let next = self.storyboard!.instantiateViewController(withIdentifier: "vc2") as? ViewController2
            self.present(next!,animated: true, completion: { () in
                next?.nameLabel.text = item.name
                next?.priceLabel.text = "¥\(item.price)"
                next?.productIamgeView.image = UIImage(named: item.imageName)
            })
            
            
        }).disposed(by: bag)
        
        viewModel.fetchProductList()
    }
    func sendpage(){
        
    }

}
//extensionでUITableViewDelegate
extension ViewController: UITableViewDelegate {
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
