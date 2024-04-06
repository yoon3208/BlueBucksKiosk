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
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    let cartBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = .bluebucks
        btn.setImage(UIImage(systemName: "cart"), for: .normal)
        btn.tintColor = .white
        var btnConfig = UIButton.Configuration.tinted()
        btnConfig.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        btn.configuration = btnConfig
        return btn
    }()
    
    let cartCountLabel: UILabel = {
        let label = UILabel()
        label.layer.borderWidth = 1.5
        label.layer.borderColor = UIColor.bluebucks.cgColor
        label.text = "0"
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.backgroundColor = .white
        label.textAlignment = .center
        return label
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
    }
    
    private func setConstraint() {
        self.addSubview(categoriesSC)
        self.addSubview(drinkCollectionView)
        self.addSubview(cartBtn)
        self.addSubview(cartCountLabel)
        
        categoriesSC.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(45)
        }
        
        drinkCollectionView.snp.makeConstraints {
            $0.top.equalTo(categoriesSC.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        cartBtn.snp.makeConstraints {
            $0.width.height.equalTo(66)
            $0.trailing.equalToSuperview().offset(-26)
            $0.bottom.equalToSuperview().offset(-50)
        }
        
        cartCountLabel.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerX.equalTo(self.cartBtn.snp.centerX).offset(25)
            $0.centerY.equalTo(self.cartBtn.snp.centerY).offset(-20)
        }
    }
}
