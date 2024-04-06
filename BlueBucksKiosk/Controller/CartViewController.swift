//
//  CartViewController.swift
//  BlueBucksKiosk
//
//  Created by 한철희 on 4/2/24.
//

import UIKit

class CartViewController: UIViewController {
    private let productManager = ProductManager()
    
    // MARK: - @IBOutlet
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var menuCnt: UILabel!
    @IBOutlet weak var menuPriceSum: UILabel!
    @IBOutlet weak var purchaseBtn: UIButton!
    @IBOutlet weak var allClearBtn: UIButton!
    // MARK: - @IBAction
    @IBAction func allClearBtnPressed(_ sender: Any) {
        showCancelAlert()
    }
    
    @IBAction func purchaseBtnPressed(_ sender: Any) {
        purchaseAlert()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // purchaseBtn 색상 변경
        purchaseBtn.setTitle("결제하기", for: .normal)
        purchaseBtn.setTitleColor(.white, for: .normal)
        purchaseBtn.backgroundColor = .bluebucks
        var buttonConfig = UIButton.Configuration.tinted()
        buttonConfig.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 0, bottom: 16, trailing: 0)
        purchaseBtn.configuration = buttonConfig
        purchaseBtn.clipsToBounds = true
        purchaseBtn.layer.cornerRadius = 8
        // allClearBtn
        allClearBtn.layer.cornerRadius = 8
        // cartTableView
        cartTableView.layer.cornerRadius = 8
        // menuView
        menuView.layer.cornerRadius = 8
        // 테이블 뷰 관련 설정
        cartTableView.delegate = self
        cartTableView.dataSource = self
        // menuCnt, menuPriceSum 설정
        menuCnt.textColor = .bluebucks
        menuPriceSum.textColor = .bluebucks
        // 초기값 세팅
        updateCartInfo()
    }
    
    // MARK: - function
    func calculateTotalPrice(for productList: [Product]) -> Int {
        return productList.reduce(0) { total, product in
            let price: Int
            switch product.size {
            case .tall:
                price = product.drink.price.0
            case .grande:
                price = product.drink.price.1
            case .venti:
                price = product.drink.price.2
            }
            return total + price * product.count
        }
    }
    // product 정보 업데이트
    func updateCartInfo() {
        let productList = productManager.getProductList()
        let totalItems = productList.count
        let totalPrice = calculateTotalPrice(for: productList)
        
        menuCnt.text = "\(totalItems)개"
        menuPriceSum.text = "\(totalPrice)원"
    }
    // 삭제하기 버튼 눌렀을 때 얼럿
    func showCancelAlert() {
        let alert = UIAlertController(title: nil, message: "전체 삭제 하시겠습니까?", preferredStyle: .alert)
        
        // 확인 버튼 클릭 시 테이블 뷰 전체 삭제 기능 추가
        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] action in
            self?.productManager.deleteAllProduct()
            self?.cartTableView.reloadData()
            self?.updateCartInfo() // 카트 정보 업데이트
        }
        
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    // 결제하기 버튼 눌렀을 때 나타나는 얼럿
    func purchaseAlert() {
        // 카트에 제품이 있는지 확인
        guard !productManager.getProductList().isEmpty else {
            // 제품이 없는 경우 알림창 표시
            let alert = UIAlertController(title: "알림", message: "결제할 상품이 없습니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
            return
        }
        
        // 카트에 제품이 있는 경우 결제 확인 알림창 표시
        let alert = UIAlertController(title: nil, message: "전체 결제 하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default) { (action) in
            // 확인 버튼을 눌렀을 때 실행될 코드
            self.secondAlert()
        }
        
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    func secondAlert() {
        let secondAlert = UIAlertController(title: nil, message: "결제가 완료되었습니다.", preferredStyle: .alert)
        
        // 메인화면으로 전환
        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] action in
            self?.productManager.deleteAllProduct() // 모든 제품 삭제
            self?.cartTableView.reloadData() // 테이블 뷰 새로고침
            self?.dismiss(animated: true, completion: nil) // 뷰 컨트롤러 닫기
        }
        
        secondAlert.addAction(ok)
        
        present(secondAlert, animated: true, completion: nil)
    }
    
    func countWarningAlert() {
        let alert = UIAlertController(title: "경고", message: "1개 미만으로 선택하실 수 없습니다", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - extension
extension CartViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
}

extension CartViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productManager.getProductList().count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else {
            // 캐스팅 실패 시 안전한 대체 셀 반환
            print("ShoppingCartCell로 캐스팅할 수 없습니다.")
            return UITableViewCell()
        }
        let product = productManager.getProductList()[indexPath.row]
        cell.product = product
        
        // 증가 클로저
        cell.increaseClosure = { [weak self] in
            guard let self = self else { return }
            if self.productManager.increaseDrinkCount(product: product) {
                tableView.reloadRows(at: [indexPath], with: .none)
                self.updateCartInfo()
            }
        }
        
        // 감소 클로저
        cell.decreaseClosure = { [weak self] in
            guard let self = self else { return }
            if self.productManager.decreaseDrinkCount(product: product) {
                tableView.reloadRows(at: [indexPath], with: .none)
            } else {
                // 수량이 1이하일 때는 숫자 변경 x
                countWarningAlert()
            }
            self.updateCartInfo()
        }
        
        // 삭제 클로저
        cell.deleteClosure = { [weak self] in
            guard let self = self else { return }
            
            // 데이터 모델에서 셀에 해당하는 데이터 삭제
            if self.productManager.deleteProduct(product: product) {
                // 테이블 뷰에서 해당 셀 삭제
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            // 카트 정보 업데이트
            self.updateCartInfo()
        }
        return cell
    }
}

