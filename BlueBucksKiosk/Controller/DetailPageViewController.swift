//
//  DetailPageViewController.swift
//  BlueBucksKiosk
//
//  Created by 박윤희 on 2024/04/02.
//

import UIKit

class DetailPageViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var engNameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var sizeDescription: UILabel!
    @IBOutlet var boxBtn: UIButton!
    
    
    //뷰 컨트롤러의 UI 요소들을 그 값에 맞게 업데이트
    var drink: Drink?
    
    var completion: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        boxBtn.setTitle("담기", for: .normal)
        boxBtn.setTitleColor(.white, for: .normal)
        boxBtn.backgroundColor = .bluebucks
        var buttonConfig = UIButton.Configuration.tinted()
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        boxBtn.configuration = buttonConfig
        boxBtn.clipsToBounds = true
        boxBtn.layer.cornerRadius = 8
        
        if let drink = drink {
            self.imageView.image = drink.image
            self.nameLabel.text = drink.name.0
            self.engNameLabel.text = drink.name.1
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            
            if let formattedPrice0 = numberFormatter.string(for: drink.price.0),
               let formattedPrice1 = numberFormatter.string(for: drink.price.1),
               let formattedPrice2 = numberFormatter.string(for: drink.price.2) {
                
                self.priceLabel.text = "\(formattedPrice0)원"
                self.descriptionText.text = drink.description
                self.sizeDescription.text = """
            <사이즈별 가격 안내>
            Tall size : \(formattedPrice0)원
            Grande size : \(formattedPrice1)원
            Venti size : \(formattedPrice2)원
            """
            }
        }
        self.navigationItem.backBarButtonItem?.tintColor = .bluebucks
    }
 
    @IBAction func tappedBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    //버튼을 누르면 다음 뷰컨트롤러로 이동 및 정보 전달
    @IBAction func tappedInto(_ sender: UIButton) {
        let optionStoryboard = UIStoryboard (name: "OptionStoryboard", bundle: .main)
        let optionViewController = optionStoryboard.instantiateViewController (withIdentifier: "OptionView") as! OptionViewController
        optionViewController.drink = self.drink
        optionViewController.completion = completion
        
        self.navigationController?.pushViewController(optionViewController, animated: true)
    }
}
