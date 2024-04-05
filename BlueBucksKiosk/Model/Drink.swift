//
//  Drink.swift
//  BlueBucksKiosk
//
//  Created by 박윤희 on 2024/04/03.
//

import UIKit

struct Drink {
    let id: UUID
    let name: (String, String)
    let image: UIImage
    let description: String
    let price: (Int, Int, Int)
    let category: Category
}

enum Category {
    case espresso
    case frappuccino
    case teavana
    case etc
}
