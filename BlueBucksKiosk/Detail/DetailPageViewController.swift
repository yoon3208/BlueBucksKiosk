//
//  DetailPageViewController.swift
//  BlueBucksKiosk
//
//  Created by SAMSUNG on 2024/04/02.
//

import UIKit

class DetailPageViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet var descriptionText: UILabel!
    
    
    
    struct Drink {
        var name: (String, String)
        var image: UIImage
        var description: String = ""
        var price: Int
    }
    
    var selectedImage: UIImage?
    var selectedName: String = "제품명"
    var selectedPrice: Int = 0
    
    let productDescription: [String: String] = [
        "아이스 아메리카노": "블루벅스만의 깔끔하고 강렬한 에스프레소를 가장 부드럽고 시원하게 즐길 수 있는 커피"
                                              ]

    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        imageView.image = selectedImage
        nameLabel.text = selectedName
        priceLabel.text = "\(selectedPrice)₩"
        
        if let drinkDescription = productDescription[selectedName]{
            descriptionText.text = drinkDescription
        }else{
            descriptionText.text = "상세설명 없음"
        }
    }
   
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // if segue.identifier == "세그웨이 식별자 이름"
//        if segue.identifier == ""{
//            //if let nextVC = segue.destination as? 다음 뷰 컨트롤러 이름
//            if let nextVC = segue.destination as? _ {
//                nextVC.selectedName = selectedName
//                nextVC.
//            }
//        }
//    }
//
//
//
//
//    @IBAction func tappedInto(_ sender: Any) {
//        //performSegue(withIdentifier: "세그웨이 식별자 이름", sender: nil)
//        performSegue(withIdentifier: <#T##String#>, sender: nil)
//
//    }
//
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
