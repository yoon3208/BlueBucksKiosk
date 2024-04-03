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
    
    @IBOutlet weak var drinkName: UILabel! {
        didSet {
            drinkName.text = "\(selectedName)"
        }
    }
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
        
        // 다른 버튼들의 상태를 초기화합니다.
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
    }
    
    
    @IBAction func grandeButton(_ sender: Any) {
        // 이전에 grande 버튼이 눌렸던 상태를 저장합니다.
        let wasGrandeButtonPressed = grandeButtonPressed
        
        grandeButtonPressed.toggle()
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        // 다른 버튼들의 상태를 초기화합니다.
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        // 이전에 grande 버튼이 눌려있었던 경우
        if wasGrandeButtonPressed {
            // 500을 selectedPrice에서 빼고, 변경된 값을 optionAddPrice 레이블에 표시합니다.
            selectedPrice -= 500
            optionAddPrice.text = "가격: \(selectedPrice)"
        } else {
            // 이전에 grande 버튼이 눌리지 않았던 경우
            // 500을 selectedPrice에 더하고, 변경된 값을 optionAddPrice 레이블에 표시합니다.
            selectedPrice += 500
            optionAddPrice.text = "가격: \(selectedPrice)"
        }
    }
    
    @IBAction func ventiButton(_ sender: Any) {
        let wasVentiButtonPressed = ventiButtonPressed
        
        ventiButtonPressed.toggle()
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        // 다른 버튼들의 상태를 초기화합니다.
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        if wasVentiButtonPressed {
            // 500을 selectedPrice에서 빼고, 변경된 값을 optionAddPrice 레이블에 표시합니다.
            selectedPrice -= 1000
            optionAddPrice.text = "가격: \(selectedPrice)"
        } else {
            // 이전에 grande 버튼이 눌리지 않았던 경우
            // 500을 selectedPrice에 더하고, 변경된 값을 optionAddPrice 레이블에 표시합니다.
            selectedPrice += 1000
            optionAddPrice.text = "가격: \(selectedPrice)"
        }
    }
    
    @IBOutlet weak var optionAddPrice: UILabel! {
        didSet {
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
        // tall 버튼의 상태를 변경합니다.
        tallButtonPressed.toggle()
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
        // 다른 버튼들의 상태를 초기화합니다.
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
    }
    
    @objc func toggleGrandeButton(_ sender: UITapGestureRecognizer) {
        // 이전에 grande 버튼이 눌렸던 상태를 저장합니다.
        let wasGrandeButtonPressed = grandeButtonPressed
        
        // grande 버튼의 상태를 변경합니다.
        grandeButtonPressed.toggle()
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        // 다른 버튼들의 상태를 초기화합니다.
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        // 이전에 grande 버튼이 눌려있었던 경우
        if wasGrandeButtonPressed {
            // 500을 selectedPrice에서 빼고, 변경된 값을 optionAddPrice 레이블에 표시합니다.
            selectedPrice -= 500
            optionAddPrice.text = "가격: \(selectedPrice)"
        } else {
            // 이전에 grande 버튼이 눌리지 않았던 경우
            // 500을 selectedPrice에 더하고, 변경된 값을 optionAddPrice 레이블에 표시합니다.
            selectedPrice += 500
            optionAddPrice.text = "가격: \(selectedPrice)"
        }
    }

    @objc func toggleVentiButton(_ sender: UITapGestureRecognizer) {
        let wasVentiButtonPressed = ventiButtonPressed
        
        // venti 버튼의 상태를 변경합니다.
        ventiButtonPressed.toggle()
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        // 다른 버튼들의 상태를 초기화합니다.
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        if wasVentiButtonPressed {
            // 500을 selectedPrice에서 빼고, 변경된 값을 optionAddPrice 레이블에 표시합니다.
            selectedPrice -= 1000
            optionAddPrice.text = "가격: \(selectedPrice)"
        } else {
            // 이전에 grande 버튼이 눌리지 않았던 경우
            // 500을 selectedPrice에 더하고, 변경된 값을 optionAddPrice 레이블에 표시합니다.
            selectedPrice += 1000
            optionAddPrice.text = "가격: \(selectedPrice)"
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


