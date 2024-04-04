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
    var addedOption: String = "" // 추가된 옵션
    
    var selectedName: String = "" // 선택된 음료 명
    
    @IBOutlet weak var tallButton: UIView! // 톨 사이즈 버튼(UIView)
    @IBOutlet weak var grandeButton: UIView! // 그란데 사이즈 버튼(UIView)
    @IBOutlet weak var ventiButton: UIView! // 벤티 사이즈 버튼(UIView)
    
    var tallButtonPressed: Bool = false
    var grandeButtonPressed: Bool = false
    var ventiButtonPressed: Bool = false
    
    @IBAction func tallButton(_ sender: Any) { // 톨 사이즈 버튼(UIButton)
        tallButtonPressed.toggle()
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed) // 버튼이 눌린 여부에 따라 외관 업데이트
        
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        addedOption = tallButtonPressed ? "tall" : "" // 버튼이 눌렸을 경우 "tall", 아닐 경우 빈 문자열을 추가된 옵션에 업데이트
    }
    
    
    @IBAction func grandeButton(_ sender: Any) { // 그란데 사이즈 버튼(UIButton)
        grandeButtonPressed.toggle()
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed) // 버튼이 눌린 여부에 따라 외관 업데이트
        
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        if !grandeButtonPressed {
            sizeOptionPrice -= 500
            if ventiButtonPressed && tallButtonPressed {
                sizeOptionPrice -= 500
            }
        } else {
            sizeOptionPrice += 500
        }
        addedOption = grandeButtonPressed ? "grande" : "" // 버튼이 눌렸을 경우 "grande", 아닐 경우 빈 문자열을 추가된 옵션에 업데이트
        
        resetOtherButtonStates(grandeButton)
        updateOptionAddPrice()
    }
    
    @IBAction func ventiButton(_ sender: Any) { // 벤티 사이즈 버튼(UIButton)
        ventiButtonPressed.toggle()
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed) // 버튼이 눌린 여부에 따라 외관 업데이트
        
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        if !ventiButtonPressed {
            sizeOptionPrice -= 1000
            if grandeButtonPressed && tallButtonPressed{
                sizeOptionPrice -= 1000
            }
        } else {
            sizeOptionPrice += 1000
        }
        addedOption = ventiButtonPressed ? "venti" : "" // 버튼이 눌렸을 경우 "venti", 아닐 경우 빈 문자열을 추가된 옵션에 업데이트
        
        resetOtherButtonStates(ventiButton)
        updateOptionAddPrice()
    }
    
    @IBOutlet weak var optionAddPrice: UILabel! { // 옵션이 더해진 총 가격
        didSet {
            updateOptionAddPrice()
        }
    }
    
    var selectedPrice: Int = 0 { // 선택된 음료 가격
        didSet {
            updateOptionAddPrice()
        }
    }
    
    var sizeOptionPrice: Int = 0 // 사이즈 옵션 추가금
    
    @IBOutlet weak var totalCount: UILabel!
    var count: Int = 1 {
        didSet {
            updateOptionAddPrice()
        }
    }
    
    func updateOptionAddPrice() { // 선택된 음료와 옵션 추가금을 더한 총 가격을 업데이트
        let totalPrice = (selectedPrice + sizeOptionPrice) * count
        optionAddPrice.text = "가격: \(totalPrice)"
    }
    
    @IBAction func addCount(_ sender: Any) { // 수량 증가 버튼
        count += 1 // totalCount 값 증가
        updateTotalCountLabel() // totalCount 레이블 업데이트
    }
    
    @IBAction func minusCount(_ sender: Any) { // 수량 감소 버튼
        if count > 1 {
            count -= 1 // totalCount 값 감소 (최소값 1로 유지)
            updateTotalCountLabel() // totalCount 레이블 업데이트
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateTotalCountLabel() // 총 수량 업데이트
        configureGestureRecognizers() // 각 버튼에 대한 제스처 인식기
        
        // 컵 사이즈 버튼(UIView)에 대한 레이어 속성 설정
        tallButton.layer.cornerRadius = 5 // 버튼의 둥근 모서리 값
        tallButton.layer.borderWidth = 1 // 버튼의 테두리 두께 값
        tallButton.layer.borderColor = UIColor.lightGray.cgColor // 버튼의 테두리 색상
        
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
        // 톨 사이즈 버튼(UIView) 탭 제스처 실행 시, toggleTallButton(_:) 메서드 실행
        
        let grandeTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleGrandeButton(_:)))
        grandeButton.addGestureRecognizer(grandeTapGesture)
        // 그란데 사이즈 버튼(UIView) 탭 제스처 실행 시, toggleGrandeButton(_:) 메서드 실행
        
        let ventiTapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleVentiButton(_:)))
        ventiButton.addGestureRecognizer(ventiTapGesture)
        // 벤티 사이즈 버튼(UIView) 탭 제스처 실행 시, toggleVentiButton(_:) 메서드 실행
    }
    
    @objc func toggleTallButton(_ sender: UITapGestureRecognizer) {
        tallButtonPressed.toggle()
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed) // 버튼이 눌린 여부에 따라 외관 업데이트
        
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        addedOption = tallButtonPressed ? "tall" : ""  // 버튼이 눌렸을 경우 "tall", 아닐 경우 빈 문자열을 추가된 옵션에 업데이트
    }
    
    @objc func toggleGrandeButton(_ sender: UITapGestureRecognizer) {
        grandeButtonPressed.toggle()
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed) // 버튼이 눌린 여부에 따라 외관 업데이트
        
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        ventiButtonPressed = false
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed)
        
        if !grandeButtonPressed {
            sizeOptionPrice -= 500
            if ventiButtonPressed && tallButtonPressed {
                sizeOptionPrice -= 500
            }
        } else {
            sizeOptionPrice += 500
        }
        addedOption = grandeButtonPressed ? "grande" : "" // 버튼이 눌렸을 경우 "grande", 아닐 경우 빈 문자열을 추가된 옵션에 업데이트
        
        resetOtherButtonStates(grandeButton)
        updateOptionAddPrice()
        
    }
    
    @objc func toggleVentiButton(_ sender: UITapGestureRecognizer) {
        ventiButtonPressed.toggle()
        updateButtonAppearance(for: ventiButton, isPressed: ventiButtonPressed) // 버튼이 눌린 여부에 따라 외관 업데이트
        
        tallButtonPressed = false
        updateButtonAppearance(for: tallButton, isPressed: tallButtonPressed)
        grandeButtonPressed = false
        updateButtonAppearance(for: grandeButton, isPressed: grandeButtonPressed)
        
        if !ventiButtonPressed { // venti 버튼이 눌리지 않은 경우
            sizeOptionPrice -= 1000
            if grandeButtonPressed && tallButtonPressed { // grande 버튼, tall 버튼 둘 다 눌려 있는 경우 추가된 값 다시 취소
                sizeOptionPrice -= 1000
            }
        } else {
            sizeOptionPrice += 1000
        }
        addedOption = ventiButtonPressed ? "venti" : "" // 버튼이 눌렸을 경우 "venti", 아닐 경우 빈 문자열을 추가된 옵션에 업데이트
        
        resetOtherButtonStates(ventiButton)
        updateOptionAddPrice()
    }
    
    
    func resetOtherButtonStates(_ selectedButton: UIView) {
        
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
