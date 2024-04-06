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
    private let drinkManager = DrinkManager()
    
    private var drinks = [Drink]()
    
    // To Do - 병합 후 수정
    let minimumLineSpacing: CGFloat = 5
    
    // MARK: - life cycles
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDatas()
        setAddTarget()
        setNavigation()
        setCollectionView()
        initSegmentedControl()
    }
    
    private func initDatas() {
        drinks = self.drinkManager.getDrinksOfCategory(category: .espresso)
    }
    
    private func setAddTarget() {
        self.mainView.cartBtn.addTarget(self, action: #selector(didTappedCartBtn), for: .touchUpInside)
        self.mainView.categoriesSC.addTarget(self, action: #selector(didChangedSCValue), for: .valueChanged)
    }
    
    private func setNavigation() {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    private func setCollectionView() {
        self.mainView.drinkCollectionView.delegate = self
        self.mainView.drinkCollectionView.dataSource = self
        
        let nib = UINib(nibName: "CollectionViewCell", bundle: .main)
        self.mainView.drinkCollectionView.register(nib, forCellWithReuseIdentifier: "CollectionViewCell")
    }
    
    private func initSegmentedControl() {
        self.mainView.categoriesSC.selectedSegmentIndex = 0
        
        self.mainView.categoriesSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.gray],
                                                          for: .normal)
        self.mainView.categoriesSC.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.bluebucks,
                                                           .font: UIFont.systemFont(ofSize: 13,weight: .semibold)], for: .selected)
    }
    
    @objc private func didChangedSCValue(segment: UISegmentedControl) {
        switch segment.selectedSegmentIndex {
        case 0:
            drinks = self.drinkManager.getDrinksOfCategory(category: .espresso)
        case 1:
            drinks = self.drinkManager.getDrinksOfCategory(category: .frappuccino)
        case 2:
            drinks = self.drinkManager.getDrinksOfCategory(category: .teavana)
        default:
            drinks = self.drinkManager.getDrinksOfCategory(category: .etc)
        }
        self.mainView.drinkCollectionView.reloadData()
    }
    
    @objc private func didTappedCartBtn(button: UIButton) {
        let cartStoryboard = UIStoryboard(name: "CartStoryboard", bundle: .main)
        let cartViewController = cartStoryboard.instantiateViewController(withIdentifier: "CartViewController") as! CartViewController
        self.present(cartViewController, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailStoryboard = UIStoryboard(name: "DetailPage", bundle: .main)
        let detailViewController = detailStoryboard.instantiateViewController(withIdentifier: "DetailPageViewController") as! DetailPageViewController
        detailViewController.drink = drinks[indexPath.row]
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return drinks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        cell.drink = drinks[indexPath.row]
        
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    // 셀의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width/2 - minimumLineSpacing
        return CGSize(width: width, height: width+50)
    }
    
    // 지정 된 섹션의 행 사이 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minimumLineSpacing
    }
    
    // 지정 된 섹션의 셀 사이 최소 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // To Do - 병합 후 수정
        return 10
    }
}
