
import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var price: UILabel!
    
    // 데이터 초기값 설정 후 UI에 매칭
    var drink : Drink? {
        didSet {
            layoutSubviews()
            if let drink = drink {
                cellImage.image = drink.image
                name.text = drink.name.0
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let tallPrice = drink.price.0
                let tallPriceResult = numberFormatter.string(for: tallPrice)
                price.text = "\(tallPriceResult!)원"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        cellImage.layer.cornerRadius = 70
        cellImage.layer.borderWidth = 2
        cellImage.clipsToBounds = true
        cellImage.layer.borderColor = UIColor.bluebucks.cgColor
    }
}
