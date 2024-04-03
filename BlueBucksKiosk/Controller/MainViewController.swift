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
    
    // To Do - 병합 후 수정
    let minimumLineSpacing: CGFloat = 10
    
    // MARK: - life cycles
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAddTarget()
        //setCollectionView() // To Do - 연결 할 때 주석 삭제
        initSegmentedControl()
    }
    
    private func setAddTarget() {
        self.mainView.categoriesSC.addTarget(self, action: #selector(didChangedSCValue), for: .valueChanged)
        self.mainView.shoppingBasketBtn.addTarget(self, action: #selector(didTappedShoppingBasketBtn), for: .touchUpInside)
    }
    
    private func setCollectionView() {
        self.mainView.drinkCollectionView.delegate = self
        self.mainView.drinkCollectionView.dataSource = self
        
        // To Do - cell regist
        // self.mainView.drinkCollectionView.register.(<#T##cellClass: AnyClass?##AnyClass?#>, forCellWithReuseIdentifier: <#T##String#>)
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
            break
        case 1:
            break
        case 2:
            break
        default:
            break
        }
    }
    
    @objc private func didTappedShoppingBasketBtn(button: UIButton) {
        // To Do - 추가 된 데이터와 함께 장바구니로 이동
    }
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // To Do - reload 될 때 동적으로 수정
        return 80
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // To Do - 병합 후 수정
        // guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>) as? "example" else { return UICollectionViewCell() }
        // return cell
        
        // To Do - 병합 할 떄 삭제
        return UICollectionViewCell()
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    // 셀의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // To Do - 병합 후 수정
        let width = collectionView.frame.width/3 - minimumLineSpacing
        return CGSize(width: width, height: width)
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
