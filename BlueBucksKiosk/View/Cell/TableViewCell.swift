
import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cellCount: UILabel!
    
    //예상 변수 이름 설정
    // var 더하기 빼기 : ((bool) -> ())?
    // var 종료 ((bool) -> ())?
    var increaseClosure: (() -> Void)?
    var decreaseClosure: (() -> Void)?
    var deleteClosure: (() -> Void)?
    
    static let identifier = "ShoppingCartCell"
    // 데이터 초기값 설정 후 UI에 매칭
    // To-do: 데이터 변경 후 코드 수정필요
    var product : Product? {
        didSet {
            if let product = product {
                let productDrink = product.drink
                let productSize = product.size
                let productCount = product.count
                cellImage.image = productDrink.image
                name.text = productDrink.name.0
                switch productSize {
                case .tall:
                    size.text = "Tall"
                    price.text = String(productDrink.price.0)
                case .grande:
                    size.text = "Grande"
                    price.text = String(productDrink.price.1)
                case .venti:
                    size.text = "Venti"
                    price.text = String(productDrink.price.2)
                }
                
                size.textColor = .gray
                cellCount.text = String(productCount)
                cellImage.layer.cornerRadius = cellImage.frame.height / 2
                cellImage.layer.borderWidth = 3
                cellImage.clipsToBounds = true
                cellImage.layer.borderColor = UIColor.bluebucks.cgColor
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // tag값에 따라 액션이 바뀌는 함수
    @IBAction func didTappedCountButton(_ sender: UIButton) {
        if sender.tag == 0 {
            // 변수이름(bool) 파라미터 타입
            // 빼기
            decreaseClosure?()
        } else {
            // 더하기
            increaseClosure?()
        }
        if sender.tag == 2 {
            // 셀 삭제 변수이름
            deleteClosure?()
        }
    }
}
