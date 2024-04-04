
import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var cellCount: UILabel!
    

    
    //예상 변수 이름 설정
    // var 더하기 빼기 : {(bool) -> ()}
    // var 종료 {(bool)}

    // 데이터 초기값 설정 후 UI에 매칭
    var drink : Drink? {
        didSet {
            if let drink = drink {
                cellImage.image = drink.image
                name.text = drink.name.0
                //size.text = drink.size
                price.text = String(drink.price)
                cellCount.text = "1"
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
            // 플러스 변수이름
        } else {
            // 마이너스 변수이름
        }
        if sender.tag == 2 {
            // 종료하는 변수이름
        }
    }
}
