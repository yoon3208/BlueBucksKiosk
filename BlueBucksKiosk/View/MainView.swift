//
//  MainView.swift
//  BlueBucksKiosk
//
//  Created by 김정호 on 4/3/24.
//

import UIKit
import SnapKit

class MainView: UIView {

    // MARK: - properties
    let categoriesSC: UnderlineSegmentedControl = {
        let sc = UnderlineSegmentedControl(items: ["에스프레소", "프라푸치노", "티바나", "기타"])
        return sc
    }()
    
    let drinkCollectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        return cv
    }()
    
    let shoppingBasketBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("장바구니로 이동", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .bluebucks
        var buttonConfig = UIButton.Configuration.tinted()
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        btn.configuration = buttonConfig
        return btn
    }()
    
    // MARK: - methods
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.backgroundColor = .white
        
        shoppingBasketBtn.clipsToBounds = true
        shoppingBasketBtn.layer.cornerRadius = 8
    }
    
    private func setConstraint() {
        self.addSubview(categoriesSC)
        self.addSubview(drinkCollectionView)
        self.addSubview(shoppingBasketBtn)
        
        categoriesSC.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        
        drinkCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoriesSC.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(shoppingBasketBtn.snp.top).offset(-10)
        }
        
        shoppingBasketBtn.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
        }
    }
}
