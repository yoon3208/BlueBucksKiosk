//
//  OptionViewController.swift
//  BlueBucksKiosk
//
//  Created by 서혜림 on 4/3/24.
//

import UIKit

class OptionViewController: UIViewController {
    
    @IBOutlet weak var drinkName: UILabel! {
        didSet {
            drinkName.text = "\(selectedName)"
        }
    }
    var addedOption: String = "" // 추가된 옵션을 저장할 변수
    
    var selectedName: String = ""
    
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
        
        // addedOption 업데이트
                addedOption = tallButtonPressed ? "tall" : ""
    }
    
    
    @IBAction func grandeButton(_ sender: Any) {
        // 이전에 grande 버튼이 눌렸던 상태를 저장합니다.
        
        grandeButtonPressed.toggle()
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        // 다른 버튼들의 상태를 초기화합니다.
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
   
        if !grandeButtonPressed { 
            sizeOptionPrice -= 500
            // grande 버튼이 눌리지 않은 경우
                if ventiButtonPressed && tallButtonPressed { // venti, tall 버튼이 눌린 경우
                    // grande 버튼으로 인한 추가된 값인 500을 취소합니다.
                    sizeOptionPrice -= 500
                }
            } else { // venti 버튼이 눌린 경우
                // venti 버튼으로 인한 추가 값인 1000을 더합니다.
                sizeOptionPrice += 500
            }
        // addedOption 업데이트
                addedOption = tallButtonPressed ? "grande" : ""
        
        // 나머지 버튼들의 상태를 초기화합니다.
        resetOtherButtonStates(grandeButton)
        updateOptionAddPrice()
    }
    
    @IBAction func ventiButton(_ sender: Any) {
        
        ventiButtonPressed.toggle()
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        // 다른 버튼들의 상태를 초기화합니다.
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
      
        if !ventiButtonPressed { 
            sizeOptionPrice -= 1000
            // venti 버튼이 눌리지 않은 경우
                if grandeButtonPressed && tallButtonPressed{ // grande 버튼이 눌린 경우
                    // grande 버튼으로 인한 추가된 값인 500을 취소합니다.
                    sizeOptionPrice -= 1000
                }
            } else { // venti 버튼이 눌린 경우
                // venti 버튼으로 인한 추가 값인 1000을 더합니다.
                sizeOptionPrice += 1000
            }
        // addedOption 업데이트
                addedOption = tallButtonPressed ? "venti" : ""
        
        // 나머지 버튼들의 상태를 초기화합니다.
        resetOtherButtonStates(ventiButton)
        updateOptionAddPrice()
    }
    
    @IBOutlet weak var optionAddPrice: UILabel! {
        didSet {
            updateOptionAddPrice()
        }
    }
    
    var selectedPrice: Int = 0 {
        didSet {
            updateOptionAddPrice()
        }
    }
    
    var sizeOptionPrice: Int = 0 // 사이즈 옵션에 대한 추가 가격
    
    @IBOutlet weak var totalCount: UILabel!
    var count: Int = 1 {
        didSet {
            updateOptionAddPrice()
        }
    }
    
    func updateOptionAddPrice() {
           let totalPrice = (selectedPrice + sizeOptionPrice) * count
           optionAddPrice.text = "가격: \(totalPrice)"
       }
    
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
        
        // addedOption 업데이트
                addedOption = tallButtonPressed ? "tall" : ""
    }
    
    @objc func toggleGrandeButton(_ sender: UITapGestureRecognizer) {
        
        // grande 버튼의 상태를 변경합니다.
        grandeButtonPressed.toggle()
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        // 다른 버튼들의 상태를 초기화합니다.
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        if !grandeButtonPressed { 
            sizeOptionPrice -= 500
            // grande 버튼이 눌리지 않은 경우
                if ventiButtonPressed && tallButtonPressed { // venti, tall 버튼이 눌린 경우
                    // grande 버튼으로 인한 추가된 값인 500을 취소합니다.
                    sizeOptionPrice -= 500
                }
            } else { // venti 버튼이 눌린 경우
                // venti 버튼으로 인한 추가 값인 1000을 더합니다.
                sizeOptionPrice += 500
            }
        // addedOption 업데이트
                addedOption = tallButtonPressed ? "grande" : ""
        
        // 나머지 버튼들의 상태를 초기화합니다.
        resetOtherButtonStates(grandeButton)
        updateOptionAddPrice()
        
    }
    
    @objc func toggleVentiButton(_ sender: UITapGestureRecognizer) {
        
        // venti 버튼의 상태를 변경합니다.
        ventiButtonPressed.toggle()
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        // 다른 버튼들의 상태를 초기화합니다.
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        if !ventiButtonPressed { 
            sizeOptionPrice -= 1000
            // venti 버튼이 눌리지 않은 경우
                if grandeButtonPressed && tallButtonPressed { // grande 버튼이 눌린 경우
                    // grande 버튼으로 인한 추가된 값인 500을 취소합니다.
                    sizeOptionPrice -= 1000
                }
            } else { // venti 버튼이 눌린 경우
                // venti 버튼으로 인한 추가 값인 1000을 더합니다.
                sizeOptionPrice += 1000
            }
        // addedOption 업데이트
                addedOption = tallButtonPressed ? "venti" : ""
        
        // 나머지 버튼들의 상태를 초기화합니다.
        resetOtherButtonStates(ventiButton)
        updateOptionAddPrice()
    }
    
    
    func resetOtherButtonStates(_ selectedButton: UIView) {
        // 선택된 버튼을 제외한 나머지 버튼들의 상태를 초기화합니다.
        if selectedButton != tallButton {
            tallButtonPressed = false
            updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        }
        
        if selectedButton != grandeButton {
            grandeButtonPressed = false
            updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        }
        
        if selectedButton != ventiButton {
            ventiButtonPressed = false
            updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "" {
//            if let optionVC = segue.destination as? OptionViewController {
//                optionVC.selectedName = addedOption
//            }
//        }
//    }
}
