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
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet var descriptionText: UILabel!
    
    //뷰 컨트롤러의 UI 요소들을 그 값에 맞게 업데이트
    var drink: Drink?{
        didSet{
            if let drink = drink{
                self.imageView.image = drink.image
                self.nameLabel.text = drink.name.0
                self.priceLabel.text = "\(drink.price)"
                self.descriptionText.text = drink.description
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

      override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)


      }

    //segue로 다음 뷰컨트롤러에 정보 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showNextView"{
            if let nextVC = segue.destination as? OptionViewController{
                let nextVC = OptionViewController()
                nextVC.drink = self.drink
            }
        }
    }

    //버튼을 누르면 다음 뷰컨트롤러로 이동 및 정보 전달
    @IBAction func tappedInto(_ sender: UIButton) {
        //performSegue(withIdentifier: "세그웨이 식별자 이름", sender: self)
        performSegue(withIdentifier: "showNextView", sender: self)

    }

}
