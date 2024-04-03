//
//  ModalTestViewController.swift
//  BlueBucksKiosk
//
//  Created by 한철희 on 4/3/24.
//

import UIKit

class ModalTestViewController: UIViewController {

    @IBAction func ModalTestButton(_ sender: Any) {
        showModalVC()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func showModalVC() {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CartViewController") as? CartViewController else {return}
        
        if let sheet = vc.sheetPresentationController {
                sheet.detents = [.medium(), .large()]
        }
        
        self.present(vc, animated: true)
    }
//    CartViewController()

 

}
