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
    
    var drink: Drink?
    
    var completion: (() -> ())?
    
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
        
        self.drinkNameKor.text = drink?.name.0
        self.drinkNameEng.text = drink?.name.1
        
        updateTotalCountLabel()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func selectedButtonTapped(_ sender: UIButton) {
        // count가 0일 때만 count 값을 1로 설정합니다.
            if count == 0 {
                count = 1
            }

            // 버튼을 순회하면서 선택된 버튼과 나머지 버튼을 처리합니다.
            [tallBtn, grandeBtn, ventiBtn].forEach { button in
                if sender === button {
                    // 선택된 버튼인 경우
                    button.isSelected = true
                    index = sender.tag // 선택된 버튼의 태그 값을 index에 할당합니다.
                } else {
                    // 선택되지 않은 버튼인 경우
                    button.isSelected = false
                }
                updateButtonAppearance(button) // 버튼의 외관을 업데이트합니다.
            }

            updateSize() // 선택된 사이즈를 업데이트합니다.
            updateTotalCountLabel() // 총 수량 레이블을 업데이트합니다.
            let isOptionChosen = index != -1
            updateOptionAddPrice(isOptionChosen: isOptionChosen) // 옵션에 따른 가격을 업데이트합니다.
        }
    
    @IBAction func updateCount(_ sender: UIButton) {
        // 옵션을 선택하지 않은 경우 변경을 허용하지 않음
          if index == -1 {
              return
          }

          // 감소 버튼이 눌렸을 때
        if sender.tag == 3 {
              if count > 1 {
                  count -= 1
              }
          }
          // 증가 버튼이 눌렸을 때
        else if sender.tag == 4{
              count += 1
          }

          updateTotalCountLabel()
          let isOptionChosen = index != -1
          updateOptionAddPrice(isOptionChosen: isOptionChosen)
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
            completion!()
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @IBAction func clickBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Custom Methods
    
    func updateButtonAppearance(_ button: UIButton) {
        let borderColor = button.isSelected ? UIColor.bluebucks.cgColor : UIColor.lightGray.cgColor
        button.layer.cornerRadius = 5
        button.layer.borderWidth = button.isSelected ? 2 : 1
        button.layer.borderColor = borderColor
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
            optionAddPrice.text = ""
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
        let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            if let formattedPrice = numberFormatter.string(from: NSNumber(value: price)) {
                optionAddPrice.text = "\(formattedPrice)원" // 이 부분을 변경하여 가격을 표시합니다.
            }
    }
}
