//
//  OptionViewController.swift
//  BlueBucksKiosk
//
//  Created by 서혜림 on 4/3/24.
//

import UIKit

class OptionViewController: UIViewController {
    
    // MARK: - Properties
    
    var price = 0
    var count = 0
    var index = -1
    var size = Size.tall
    
    private let manager = ProductManager()
    
    var drink: Drink? {
        didSet {
            self.drinkNameKor.text = drink?.name.0
            self.drinkNameEng.text = drink?.name.1
        }
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var tallBtn: UIButton!
    @IBOutlet weak var grandeBtn: UIButton!
    @IBOutlet weak var ventiBtn: UIButton!
    
    @IBOutlet weak var drinkNameEng: UILabel!
    @IBOutlet weak var drinkNameKor: UILabel!
    @IBOutlet weak var optionAddPrice: UILabel!
    @IBOutlet weak var drinkCount: UILabel!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTotalCountLabel()
    }
    
    // MARK: - IBActions
    
    @IBAction func selectedButtonTapped(_ sender: UIButton) {
        [tallBtn, grandeBtn, ventiBtn].forEach { button in
            if sender === button {
                button.isSelected.toggle()
                index = sender.tag
            } else {
                button.isSelected = false
            }
            updateButtonAppearance(button)
        }
        updateSize()
        let isOptionChosen = index != -1
        updateOptionAddPrice(isOptionChosen: isOptionChosen)
    }
    
    @IBAction func updateCount(_ sender: UIButton) {
        // 옵션을 선택하지 않은 경우 또는 현재 버튼이 선택된 옵션과 동일한 경우에만 카운트 업데이트
        if index == -1 || sender.tag == index {
            if sender.tag != index {
                if count > 0 {
                    count -= 1
                }
            } else {
                count += 1
            } // 카운트가 1보다 큰 경우에만 실행
            updateTotalCountLabel()
            let isOptionChosen = index != -1
            updateOptionAddPrice(isOptionChosen: isOptionChosen)
        }
    }
    
    @IBAction func addToCart(_ sender: UIButton) {
        // 옵션을 선택하지 않은 경우에 알림 표시
        if index == -1 {
            let alert = UIAlertController(title: "안내", message: "상품을 선택해주세요.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        } else {
            let product = Product(drink: drink!, count: count, size: size)
            manager.addProduct(product: product)
            let mainVC = MainViewController()
            mainVC.modalPresentationStyle = .fullScreen
            self.present(mainVC, animated: true)
        }
    }
    
    // MARK: - Custom Methods
    
    func updateButtonAppearance(_ button: UIButton) {
        let borderColor = button.isSelected ? UIColor.bluebucks.cgColor : UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = button.isSelected ? 2 : 1
        button.layer.borderColor = borderColor
    }
    
    func resetOtherButtons(_ selectedButton: UIButton) {
        [tallBtn, grandeBtn, ventiBtn].forEach { button in
            button.layer.borderColor = (button == selectedButton && button.isSelected) ? UIColor.bluebucks.cgColor : UIColor.lightGray.cgColor
        }
    }
    
    func updateSize() {
        switch index {
        case 0:
            size = .tall
        case 1:
            size = .grande
        case 2:
            size = .venti
        default:
            break
        }
    }
    
    func updateTotalCountLabel() {
        drinkCount.text = "\(count)"
    }
    
    func updateOptionAddPrice(isOptionChosen: Bool) {
        guard let drink = drink else {
            optionAddPrice.text = "가격: N/A"
            return
        }
        if isOptionChosen {
            switch size {
            case .tall:
                price = drink.price.0 * count
            case .grande:
                price = drink.price.1 * count
            case .venti:
                price = drink.price.2 * count
            }
        } else {
            price = 0 // 옵션이 선택되지 않았을 때 가격 초기화
        }
        optionAddPrice.text = "가격: \(price)"
    }
}
