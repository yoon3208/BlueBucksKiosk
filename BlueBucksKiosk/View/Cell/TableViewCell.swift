
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
    var calculateClosure: ((Bool) -> ())?
    var closeClosure: ((Bool) -> ())?
    
    // 데이터 초기값 설정 후 UI에 매칭
    // To-do: 데이터 변경 후 코드 수정필요
    var drink : [(Drink, Int)]? {
        didSet {
            if let drink = drink, let (drink, count) = drink.first {
                cellImage.image = drink.image
                name.text = drink.name.0
                switch drink.size {
                            case .tall:
                                size.text = "Tall"
                            case .grande:
                                size.text = "Grande"
                            case .venti:
                                size.text = "Venti"
                            }
                price.text = String(drink.price)
                cellCount.text = String(count) // To-do : 장바구니에 담긴 갯수 가져오기
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        size.textColor = .gray
        cellImage.layer.cornerRadius = cellImage.frame.height/2
        cellImage.layer.borderWidth = 1
        cellImage.clipsToBounds = true
        cellImage.layer.borderColor = UIColor.clear.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // tag값에 따라 액션이 바뀌는 함수
    @IBAction func didTappedCountButton(_ sender: UIButton) {
        if sender.tag == 0 {
            // 변수이름(bool) 파라미터 타입
            // 빼기
            calculateClosure?(false)
        } else {
            // 더하기
            calculateClosure?(true)
        }
        if sender.tag == 2 {
            // 셀 삭제 변수이름
            closeClosure?(false)
        }
    }
    
    
}
