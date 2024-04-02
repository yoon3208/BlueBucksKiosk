//
//  DetailPageViewController.swift
//  BlueBucksKiosk
//
//  Created by SAMSUNG on 2024/04/02.
//

import UIKit

class DetailPageViewController: UIViewController {
//    var selectedDrink: Drink?

   
    @IBOutlet weak var stackView: UIStackView!
    
    var descriptionText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addDescription()

//        if let drink = selectedDrink{
//            drinkImage.image = drink.image
//            drinkKor.text = drink.name
//            drinkPrice.text = drink.price
//        }
    }
    //상세설명 추가하는 메서드
    func addDescription(){
        let description = UITextView()
        description.text = descriptionText
        description.isScrollEnabled = false
        
        //stackView에 UITextView 추가
        stackView.addArrangedSubview(description)
        
    }


    
    
    @IBAction func tappedInto(_ sender: Any) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
