import SnapKit
import UIKit
import Then
import Kingfisher

class TodayCategorySectionCell: UICollectionViewCell {
    static let id = "CategorySectionCell"
    
    // MARK: UI
    let imageView = UIImageView().then {
        $0.isUserInteractionEnabled = false
    }
    let label = UILabel().then {
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.numberOfLines = 2
        $0.textColor = .black
        $0.textAlignment = .left
    }
    // MARK: Initializer
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.addSubview(self.imageView)
        self.contentView.addSubview(self.label)
        self.imageView.snp.makeConstraints {
            $0.top.left.right.equalToSuperview()
            $0.bottom.equalToSuperview().inset(36)
        }
        self.label.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(image: "", name: "")
    }
    
    func prepare(image: String, name: String) {
        
        //MARK: - 만약 URL로 이미지 가져온다 하면 추가 할 예정 ~
        imageView.contentMode = .scaleToFill
        let url = URL(string: "https://\(image)")
        self.imageView.kf.indicatorType = .activity
        self.imageView.kf.setImage(with: url, placeholder: UIImage(named: "gift")){
            result in
            switch result {
            case .success(let value):
                print("Task done for: \(value.source.url?.absoluteString ?? "")")
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
        self.label.text = name
    }
}

