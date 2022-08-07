import UIKit
import XLPagerTabStrip
import SnapKit
import Then



class TodayViewController: UINavigationController, IndicatorInfoProvider {
    
    var nowPage : Int = 0
    
    private let scrollView = UIScrollView(
        frame: .zero
    ).then{
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
    }
    
    private let stackView = UIStackView(
        frame: .zero
        
    ).then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 0
    }
    
    private let verticalStackView = UIStackView(
        frame: .zero
        
    ).then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 4
    }
    
    private let firstCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 0
            $0.minimumInteritemSpacing = 0
        }).then{
            $0.isScrollEnabled = true
            $0.isPagingEnabled = true
            $0.showsHorizontalScrollIndicator = false
            $0.backgroundColor = .white
            $0.register(TodayPagingCollectionViewCell.self, forCellWithReuseIdentifier: TodayPagingCollectionViewCell.id)
            
        }
    
    
    private let secondCollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then {
            $0.scrollDirection = .horizontal
            $0.itemSize = CGSize(width: 36, height: 36)
        }
    ).then {
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.register(TodaySecondCollectionViewCell.self, forCellWithReuseIdentifier: TodaySecondCollectionViewCell.id)
        
    }
    
    
    private let dessertSectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout().then{
            $0.scrollDirection = .horizontal
            $0.minimumLineSpacing = 12
            $0.minimumInteritemSpacing = 8
        }
    ).then{
        $0.isScrollEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .white
        $0.register(TodayCategorySectionCell.self, forCellWithReuseIdentifier: TodayCategorySectionCell.id)
    }
    
    private let dessertLabel = UILabel(
    ).then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "디저트의 신세계 #간편패키지"
    }
    
    
    private let indicator = IndicatorViewForTodayView()
    
    private let firstView = UIView(
        frame: .zero
    )
    private let secondView = UIView(
        frame: .zero
    )
    private let thirdView = UIView(
        frame: .zero
    )
    
    
    private var images = (1...11)
        .map(String.init)
        .map { MyPagingModel(image: UIImage(named: "홈-페이지컨트롤\($0)"))}
    
    private var items = (1...17)
        .map(String.init)
        .map { MyModel(image: UIImage(named: $0), name: "이름\($0)") }
    
    
    
    override func viewDidLoad() {
        scrollView.delegate = self
        scrollView.tag = 4
        
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        firstCollectionView.tag = 1
        
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        secondCollectionView.tag = 2
        
        dessertSectionView.delegate = self
        dessertSectionView.dataSource = self
        dessertSectionView.tag = 3
        
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        self.firstView.addSubview(self.firstCollectionView)
        self.secondView.addSubview(self.secondCollectionView)
        self.thirdView.addSubview(self.dessertSectionView)
        [secondView, indicator].map{
            self.verticalStackView.addArrangedSubview($0)
        }
        [firstView, verticalStackView, dessertLabel, thirdView].map {
            self.stackView.addArrangedSubview($0)
        }
        
        

        self.scrollView.snp.makeConstraints{
            $0.top.bottom.trailing.leading.equalToSuperview()
        }
        
        self.stackView.snp.makeConstraints{
            $0.top.equalTo(scrollView.contentLayoutGuide.snp.top)
            $0.bottom.equalTo(scrollView.contentLayoutGuide.snp.bottom)
            $0.leading.equalTo(scrollView.contentLayoutGuide.snp.leading)
            $0.trailing.equalTo(scrollView.contentLayoutGuide.snp.trailing)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        
        self.firstView.snp.makeConstraints{
            $0.top.trailing.leading.equalToSuperview()
            $0.height.equalTo(187)
        }
        
        self.firstCollectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        self.verticalStackView.snp.makeConstraints{
            $0.top.equalTo(firstView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        self.secondView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.top.equalToSuperview().offset(8)
            $0.height.equalTo(120)
        }
        self.secondCollectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        self.indicator.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(166)
            $0.height.equalTo(4)
        }
        
        self.dessertLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.top.equalTo(verticalStackView.snp.bottom).offset(48)
            $0.trailing.equalToSuperview()
        }
        
        self.thirdView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.bottom.equalToSuperview()
            $0.top.equalTo(dessertLabel.snp.bottom).offset(8)
        }
        
        self.dessertSectionView.snp.makeConstraints{
            $0.top.bottom.left.right.equalToSuperview()
            $0.height.equalTo(360)
        }
        
        bannerTimer()
        
        
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let allWidth = self.secondCollectionView.contentSize.width + self.secondCollectionView.contentInset.left + self.secondCollectionView.contentInset.right
        let showingWidth = secondCollectionView.frame.width
        self.indicator.widthRatio = showingWidth / allWidth
        self.indicator.layoutIfNeeded()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return IndicatorInfo(title: "투데이")
    }
    
    
    // 2초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == images.count-1 {
            // 맨 처음 페이지로 돌아감
            firstCollectionView.isPagingEnabled = false
            firstCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            firstCollectionView.isPagingEnabled = true
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        firstCollectionView.isPagingEnabled = false
        firstCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
        firstCollectionView.isPagingEnabled = true
    }
    
}

extension TodayViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right:  0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag{
        case 1:
            return images.count
        case 2:
            return items.count
        case 3:
            return Constant.categoryProductList[0].productsList.count
        default:
            return 1
        }
    }
    
    
    //컬렉션뷰 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 1{
            let cell = (firstCollectionView.dequeueReusableCell(withReuseIdentifier: TodayPagingCollectionViewCell.id, for: indexPath) as! TodayPagingCollectionViewCell).then {
                let image = self.images[indexPath.row]
                $0.prepare(image: image.image)
            }
            
            return cell
        }
        else if collectionView.tag == 2{
            let cell = (secondCollectionView.dequeueReusableCell(withReuseIdentifier: TodaySecondCollectionViewCell.id, for: indexPath) as! TodaySecondCollectionViewCell).then {
                let item = self.items[indexPath.item]
                $0.prepare(image: item.image, name: item.name)
            }
            return cell
        }
        else if collectionView.tag == 3{
            let cell = (dessertSectionView.dequeueReusableCell(withReuseIdentifier: TodayCategorySectionCell.id, for: indexPath) as! TodayCategorySectionCell).then{
                let item = Constant.categoryProductList[0].productsList[indexPath.row]
                $0.prepare(image: item.productImg, name: item.productTitle)
            }
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 3 {
            Constant.selectedProduct = Constant.categoryProductList[0].productsList[indexPath.row].productID
            let vc = ProductDetailViewController()
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true)
        }
    }
    
    // UICollectionViewDelegateFlowLayout 상속
    //컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 1{
            return CGSize(width: firstCollectionView.frame.size.width, height:  collectionView.frame.size.height)
        }
        else if collectionView.tag == 2 {
            let width = secondCollectionView.frame.width
            let height = collectionView.bounds.height
            let itemsPerRow: CGFloat = 5
            let widthPadding = 8 * (itemsPerRow + 1)
            let itemsPerColumn: CGFloat = 2
            let heightPadding = 8 * (itemsPerColumn + 1)
            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = (height - heightPadding) / itemsPerColumn
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        else if collectionView.tag == 3 {
            let width = thirdView.frame.width
            let height = collectionView.bounds.height
            let itemsPerRow: CGFloat = 2.5
            let widthPadding = 8 * (itemsPerRow + 1)
            let itemsPerColumn: CGFloat = 2
            let heightPadding = 8 * (itemsPerColumn + 1)
            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = (height - heightPadding) / itemsPerColumn
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        else {
            return CGSize(width: 0, height: 0)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // contentOffset: 스크롤한 길이
        // contentInset: collectionView의 테두리 부분과의 여백 (4곳만 존재)
        // contentSize: 스크롤 가능한 콘텐츠 사이즈 (주의 - contentInset 값을 합해야, collectionView 전체 콘텐트 사이즈)
        
        if scrollView == secondCollectionView{
            DispatchQueue.main.async {
                let scroll = scrollView.contentOffset.x + scrollView.contentInset.left
                let width = scrollView.frame.width + scrollView.contentInset.left + scrollView.contentInset.right
                let scrollRatio = scroll / width
                self.indicator.leftOffsetRatio = scrollRatio
            }
        }
    }
    
    
    //컬렉션뷰 감속 끝났을 때 현재 페이지 체크
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView, _ collectionView : UICollectionView) {
        if collectionView.tag == 1{
            //print("현재페이지: \(nowPage)")
            nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        }
    }
    
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.tag == 1{
            nowPage+=1
        }
    }
}

