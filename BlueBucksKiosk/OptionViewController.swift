//
//  OptionViewController.swift
//  BlueBucksKiosk
//
//  Created by 서혜림 on 4/3/24.
//

import UIKit

struct Drink {
    var name: (String, String)
    var image: UIImage
    var description: String
    var price: Int
    var category: Category
    var size: Size
}

enum Category {
    case espresso
    case frappuccino
    case teavana
    case etc
}

enum Size: Int {
    case tall = 355
    case grande = 473
    case venti = 591
}

class OptionViewController: UIViewController {
    
    @IBOutlet weak var DrinkName: UILabel!
    var selectedName: String = "아이스 아메리카노"
    
    @IBOutlet weak var tallButton: UIView!
    
    @IBOutlet weak var grandeButton: UIView!
    
    @IBOutlet weak var ventiButton: UIView!
    
    var tallButtonPressed: Bool = false
    var grandeButtonPressed: Bool = false
    var ventiButtonPressed: Bool = false
    
    @IBAction func tallButton(_ sender: Any) {
        tallButtonPressed.toggle()
            updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
    }
    
    @IBAction func grandeButton(_ sender: Any) {
        grandeButtonPressed.toggle()
            updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
    }
    @IBAction func ventiButton(_ sender: Any) {
        ventiButtonPressed.toggle()
            updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
    }
    @IBOutlet weak var optionAddPrice: UILabel! {
        didSet {
            var selectedPrice: Int = 4500
            optionAddPrice.text = "가격: \(selectedPrice)"
        }
    }
    var selectedPrice: Int = 4500

    
    @IBOutlet weak var totalCount: UILabel!
    var count: Int = 1
    
    @IBAction func addCount(_ sender: Any) {
        count += 1 // totalCount 값 증가
        updateTotalCountLabel() // totalCount 레이블 업데이트
    }
    
    @IBAction func minusCount(_ sender: Any) {
        if count > 1 {
            count -= 1 // totalCount 값 감소 (단, 최소값은 1로 유지)
            updateTotalCountLabel() // totalCount 레이블 업데이트
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTotalCountLabel()
        configureGestureRecognizers()
        
        tallButton.layer.cornerRadius = 5
        tallButton.layer.borderWidth = 1
        tallButton.layer.borderColor = UIColor.lightGray.cgColor
        
        grandeButton.layer.cornerRadius = 5
        grandeButton.layer.borderWidth = 1
        grandeButton.layer.borderColor = UIColor.lightGray.cgColor
        
        ventiButton.layer.cornerRadius = 5
        ventiButton.layer.borderWidth = 1
        ventiButton.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func configureGestureRecognizers() {
        let tallTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleTallButton(_:)))
        tallButton.addGestureRecognizer(tallTapGesture)
        
        let grandeTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleGrandeButton(_:)))
        grandeButton.addGestureRecognizer(grandeTapGesture)
        
        let ventiTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleVentiButton(_:)))
        ventiButton.addGestureRecognizer(ventiTapGesture)
    }
    
    @objc func toggleTallButton(_ sender: UITapGestureRecognizer) {
        
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        tallButtonPressed.toggle()
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
    }
    
    @objc func toggleGrandeButton(_ sender: UITapGestureRecognizer) {
        
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        grandeButtonPressed.toggle()
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        // 만약 grandeButton이 눌린 상태라면, 가격에 500을 더합니다.
           if grandeButtonPressed {
               selectedPrice += 500
           }
           
           // 만약 ventiButton이 눌린 상태라면, 가격에 1000을 더합니다.
           if ventiButtonPressed {
               selectedPrice += 1000
           }
    }
    
    @objc func toggleVentiButton(_ sender: UITapGestureRecognizer) {
        
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        ventiButtonPressed.toggle()
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        // 만약 grandeButton이 눌린 상태라면, 가격에 500을 더합니다.
           if grandeButtonPressed {
               selectedPrice += 500
           }
           
           // 만약 ventiButton이 눌린 상태라면, 가격에 1000을 더합니다.
           if ventiButtonPressed {
               selectedPrice += 1000
           }
    }
    
    func updateButtonAppearance(for button: UIView, isPressed: Bool) {
        let borderColor = isPressed ? UIColor(named: "maincolor")?.cgColor : UIColor.lightGray.cgColor
        button.layer.borderWidth = isPressed ? 2 : 1
        button.layer.borderColor = borderColor
    }
    
    func updateTotalCountLabel() {
        totalCount.text = "\(count)"
    }

}
