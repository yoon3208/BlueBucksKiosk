//
//  ProductManager.swift
//  BlueBucksKiosk
//
//  Created by 김정호 on 4/5/24.
//

import Foundation

final class ProductManager {

    // MARK: - properties
    private static var productList = [Product]()
    
    // MARK: - methods
    func getProductList() -> [Product] {
        return Self.productList
    }
    
    func addProduct(product: Product) {
        let isIncluded = Self.productList.firstIndex { $0.drink.id == product.drink.id && $0.size == product.size }
        
        if let isIncluded = isIncluded {
            Self.productList[isIncluded].count += product.count
        } else {
            Self.productList.append(product)
        }
    }
    
    func deleteProduct(product: Product) -> Bool {
        let isIncluded = Self.productList.firstIndex { $0.drink.id == product.drink.id && $0.size == product.size }
        
        if let isIncluded = isIncluded {
            Self.productList.remove(at: isIncluded)
            return true
        } else {
            return false
        }
    }
    
    func deleteAllProduct() {
        Self.productList.removeAll()
    }
    
    func increaseDrinkCount(product: Product) -> Bool {
        let isIncluded = Self.productList.firstIndex { $0.drink.id == product.drink.id && $0.size == product.size }
        
        if let isIncluded = isIncluded {
            Self.productList[isIncluded].count += 1
            return true
        } else {
            return false
        }
    }
    
    func decreaseDrinkCount(product: Product) -> Bool {
        let isIncluded = Self.productList.firstIndex { $0.drink.id == product.drink.id && $0.size == product.size }
        
        if let isIncluded = isIncluded, Self.productList[isIncluded].count > 1 {
            Self.productList[isIncluded].count -= 1
            return true
        } else {
            return false
        }
    }
}
