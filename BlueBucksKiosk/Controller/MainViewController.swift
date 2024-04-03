//
//  MainViewController.swift
//  BlueBucksKiosk
//
//  Created by 김정호 on 4/2/24.
//

import UIKit

final class MainViewController: UIViewController {
    
    // MARK: - properties
    private let mainView = MainView()
    
    // MARK: - life cycles
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initSegmentedControl()
    }
    
    private func initSegmentedControl() {
        self.mainView.categoriesSC.selectedSegmentIndex = 0
        
        self.mainView.categoriesSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray],
                                                          for: .normal)
        self.mainView.categoriesSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.bluebucks,
                                                           .font: UIFont.systemFont(ofSize: 13,weight: .semibold)], for: .selected)
    }
}
