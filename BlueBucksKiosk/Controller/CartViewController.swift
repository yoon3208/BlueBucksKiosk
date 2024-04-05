//
//  CartViewController.swift
//  BlueBucksKiosk
//
//  Created by 한철희 on 4/2/24.
//

import UIKit

class CartViewController: UIViewController {
    // MARK: - @IBOutlet
    @IBOutlet weak var cartTableView: UITableView!
    @IBOutlet weak var menuCnt: UILabel!
    @IBOutlet weak var menuPriceSum: UILabel!
    @IBOutlet weak var purchaseBtn: UIButton!
    // MARK: - @IBAction
    @IBAction func allClearBtnPressed(_ sender: Any) {
        showCancelAlert()
    }
    
    @IBAction func purchaseBtnPressed(_ sender: Any) {
        purchaseAlert()
    }
    
    // 초기값 세팅
    var drinks: [Drink]? {
        didSet {
            if let drinks = drinks {
                // 모든 음료 개수
                self.menuCnt.text = "\(drinks.count)개"
                // 모든 음료의 가격 합산
                let totalPrice = drinks.reduce(0) { $0 + $1.price }
                self.menuPriceSum.text = "\(totalPrice)원"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 전체 개수 및 가격 업데이트
        //        updateCartInfo()
        // 테이블 뷰 관련
        cartTable.delegate = self
        cartTable.dataSource = self
    }
    // MARK: - function
    // 개수와 가격 업데이트
    //    func updateCartInfo() {
    //        let totalItems = CartDataModel.count
    //        let totalPrice = CartDataModel.reduce(0) { $0 + $1.price }
    //
    //        menuCnt.text = "\(totalItems)개"
    //        menuPriceSum.text = "\(totalPrice)원"
    //    }
    
    func showCancelAlert() {
        let alert = UIAlertController(title: nil, message: "전체 삭제 하시겠습니까?", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        // 확인 버튼 클릭 시 테이블 뷰 전체 삭제 기능 추가
        //        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] action in
        //            CartDataModel.removeAll()
        //            self?.cartTableView.reloadData()
        //            self?.updateCartInfo() // 카트 정보 업데이트
        //        }
        
        let cancel = UIAlertAction(title: "취소", style: .destructive, handler: nil)
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
    }
    
    func purchaseAlert() {
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
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        // 이후 메인화면으로 전환 추가
        //        let ok = UIAlertAction(title: "확인", style: .default) { [weak self] action in
        //            self?.dismiss(animated: true, completion: nil)
        //        }
        
        secondAlert.addAction(ok)
        
        present(secondAlert, animated: true, completion: nil)
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
        return drinks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        let drink = CartDataModel[indexPath.row]
        cell.configure(with: drink)
        
        
        //증가 클로저
        cell.increaseClosure = { [weak self] in
            guard let self = self else { return }
            self.drinks[indexPath.row].count += 1
            // 필요한 UI 업데이트
            tableView.reloadRows(at: [indexPath], with: .none)
        }
        
        // 감소 클로저
        cell.decreaseClosure = { [weak self, weak tableView] in
            guard let self = self else { return }
            if self.drinks[indexPath.row].count > 0 {
                self.drinks[indexPath.row].count -= 1
                // 필요한 UI 업데이트
                tableView?.reloadRows(at: [indexPath], with: .none)
            } else {
                // 삭제 로직
                self.drinks.remove(at: indexPath.row)
                tableView?.deleteRows(at: [indexPath], with: .fade)
            }
        }
        cell.deletionClosure = { [weak self, weak tableView] in
            guard let self = self else { return }
            
            // 데이터 모델에서 셀에 해당하는 데이터 삭제
            self.drinks.remove(at: indexPath.row)
            
            // 테이블 뷰에서 해당 셀 삭제
            tableView?.deleteRows(at: [indexPath], with: .fade)
        }
        //
        return cell
    }
}

