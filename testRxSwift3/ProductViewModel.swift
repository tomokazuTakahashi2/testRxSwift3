//
//  ProductViewModel.swift
//  testRxSwift3
//
//  Created by Raphael on 2020/09/13.
//  Copyright © 2020 takahashi. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductViewModel {
    
    let items = PublishSubject<[Product]>()
    
    func fetchProductList() {
            //do some network call here or database query
            //but we just create fake one
            let productArray = [
                Product(imageName: "mac", name: "MacBook", price: "1500"),
                Product(imageName: "iPhone", name: "iPhone Xs", price: "1200"),
                Product(imageName: "watch", name: "iWatch", price: "300"),
                Product(imageName: "ipad", name: "iPad", price: "1100"),
                Product(imageName: "iPhoneX", name: "iPhone X", price: "999")
            ]
        
        items.onNext(productArray)
        items.onCompleted()
    }

    
}
