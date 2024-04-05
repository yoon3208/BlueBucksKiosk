//
//  Cart.swift
//  BlueBucksKiosk
//
//  Created by 김정호 on 4/5/24.
//

import Foundation

struct Cart {
    let drink: Drink
    let count: Int
    let size: Size
}

enum Size {
    case tall
    case grande
    case venti
}
