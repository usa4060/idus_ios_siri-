import SnapKit
import UIKit

class TodayPagingCollectionViewCell: UICollectionViewCell {
    static let id = "PagingCell"
    
    // MARK: UI
    private let imageView = UIImageView().then {
        $0.isUserInteractionEnabled = false
    }
    
    // MARK: Initializer
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.imageView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        print("이미지뷰 크기 : \(imageView.frame.width)")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(image: nil)
    }
    
    func prepare(image: UIImage?) {
        self.imageView.image = image
    }
}
