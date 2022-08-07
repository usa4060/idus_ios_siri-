import UIKit
import XLPagerTabStrip
import SnapKit
import Then

class OnLineViewController: UINavigationController, IndicatorInfoProvider {
    
    var nowPage : Int = 0
    
    private let scrollView = UIScrollView(
        frame: .zero
    ).then{
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.backgroundColor = .white
    }
    
    private let stackView = UIStackView(
        frame: .zero
        
    ).then{
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        $0.spacing = 4
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
    
    
    let bestReviewCollectionView = UICollectionView(
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
        $0.register(UINib(nibName: "BestReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "BestReviewCell")
    }
    
    private let bestReviewCollectionViewLabel = UILabel(
    ).then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "나만 볼 수 없는 BEST 후기 !"
        $0.backgroundColor = .white
    }
    
    let newOpenCollectionView = UICollectionView(
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
        $0.register(UINib(nibName: "NewOpenCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewOpenCell")
    }
    
    private let newOpenCollectionViewLabel = UILabel(
    ).then {
        $0.font = .systemFont(ofSize: 18, weight: .bold)
        $0.numberOfLines = 1
        $0.textColor = .black
        $0.textAlignment = .left
        $0.text = "New! 새로 오픈한 클래스"
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
    private let fourthView = UIView(
        frame: .zero
    )
    private let tempView = UIView(
        frame: .zero
    ).then{
        $0.backgroundColor = .searchFieldBorderColor
    }
    private let tempView2 = UIView(
        frame: .zero
    ).then{
        $0.backgroundColor = .searchFieldBorderColor
    }
    
    
    
    private var images = (1...5)
        .map(String.init)
        .map { MyClassPagingModel(image: UIImage(named: "클래스-페이지컨트롤\($0)"))}
    
    private let itemName : [String : String] = ["바느질/재봉":"1", "취미클래스":"2", "상반기결산":"3", "캘리그라피":"4", "원데이클래스":"5", "레진/자개":"6", "공예":"7", "뜨개/코바늘":"8", "미술/드로잉":"9", "쿠킹/디저트":"10", "데일리/소품":"11", "일러스트/굿즈":"12"]
    
    private var items : [MyClassModel] = []
    
    override func viewDidLoad() {
        OnLineDataManager().requireOnLine(self) { data in
            Constant.bestReviewList = data.bestReviewList
            Constant.newOpenClassesList = data.newOpenClassesList
            Constant.userLikeClassesList = data.userLikeClassesList
            Constant.allOnlineClassesList = data.allOnlineClassesList
            self.bestReviewCollectionView.reloadData()
            self.newOpenCollectionView.reloadData()
        }
        
        for idx in itemName{
            items.append(MyClassModel(image: UIImage(named: idx.value), name: idx.key))
        }
        
        
        scrollView.delegate = self
        scrollView.tag = 100
        
        firstCollectionView.delegate = self
        firstCollectionView.dataSource = self
        firstCollectionView.tag = 1
        
        secondCollectionView.delegate = self
        secondCollectionView.dataSource = self
        secondCollectionView.tag = 2
        
        bestReviewCollectionView.delegate = self
        bestReviewCollectionView.dataSource = self
        bestReviewCollectionView.tag = 3
        
        newOpenCollectionView.delegate = self
        newOpenCollectionView.dataSource = self
        newOpenCollectionView.tag = 4
        
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.stackView)
        self.firstView.addSubview(self.firstCollectionView)
        self.secondView.addSubview(self.secondCollectionView)
        self.thirdView.addSubview(self.bestReviewCollectionView)
        self.fourthView.addSubview(self.newOpenCollectionView)
        [secondView, indicator].map{
            self.verticalStackView.addArrangedSubview($0)
        }
        [firstView, verticalStackView, tempView, bestReviewCollectionViewLabel, thirdView,tempView2,  newOpenCollectionViewLabel, fourthView].map {
            self.stackView.addArrangedSubview($0)
        }
        
        self.tempView.snp.makeConstraints{
            $0.height.equalTo(60)
        }
        self.tempView2.snp.makeConstraints{
            $0.height.equalTo(20)
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
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(187)
        }
        
        self.firstCollectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        
        self.verticalStackView.snp.makeConstraints{
            $0.leading.trailing.equalToSuperview()
        }
        
        self.secondView.snp.makeConstraints{
            $0.trailing.leading.equalToSuperview()
            $0.height.equalTo(80)
        }
        self.secondCollectionView.snp.makeConstraints {
            $0.top.left.right.bottom.equalToSuperview()
        }
        self.indicator.snp.makeConstraints {
            $0.left.right.equalToSuperview().inset(166)
            $0.height.equalTo(4)
        }
        
        self.bestReviewCollectionViewLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.top.equalTo(verticalStackView.snp.bottom).offset(48)
            $0.trailing.equalToSuperview()
        }
        
        self.thirdView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview()
            $0.height.equalTo(360)
        }
        
        self.bestReviewCollectionView.snp.makeConstraints{
            $0.top.bottom.left.right.equalToSuperview()
        }
        
        self.newOpenCollectionViewLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalToSuperview()
        }
        
        self.fourthView.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.bottom.equalToSuperview()
            $0.height.equalTo(400)
        }
        
        self.newOpenCollectionView.snp.makeConstraints{
            $0.top.bottom.left.right.equalToSuperview()
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
        return IndicatorInfo(title: "온라인")
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



extension OnLineViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
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
            return Constant.bestReviewList.count
        case 4:
            return Constant.newOpenClassesList.count
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
            let cell = (bestReviewCollectionView.dequeueReusableCell(withReuseIdentifier: "BestReviewCell", for: indexPath) as! BestReviewCollectionViewCell).then{
                let item = Constant.bestReviewList[indexPath.row]
                $0.prepare(reviewImg: item.reviewImg, nickName: item.nickName, contents: item.contents, classImg: item.classImg, classTitle: item.classTitle)
            }
            let view = UIView()
            cell.setViewShadow(backView: view)
            return cell
        }
        else if collectionView.tag == 4{
            let cell = (newOpenCollectionView.dequeueReusableCell(withReuseIdentifier: "NewOpenCell", for: indexPath) as! NewOpenCollectionViewCell).then{
                let item = Constant.newOpenClassesList[indexPath.row]
                $0.prepare(profileImg: item.profileImg, categoryName: item.categoryName, writerName: item.writerName, title: item.title, onClassID: item.classID, viewController: self, isLike: item.like)
            }
            
            return cell
        }
        else {
            return UICollectionViewCell()
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.tag == 4 {
            OnlineClassDetatilDataManager().requireOnlineClassDetail(Constant.newOpenClassesList[indexPath.row].classID, self) { data in
                Constant.onlineClassDetailResult = data
                Constant.selectedOnlineClass = Constant.newOpenClassesList[indexPath.row].classID
                let vc = OnlineClassDetailViewController()
                vc.modalPresentationStyle = .fullScreen
                vc.modalTransitionStyle = .crossDissolve
                self.present(vc, animated: true)
            }
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
            let itemsPerColumn: CGFloat = 1
            let heightPadding = 8 * (itemsPerColumn + 1)
            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = (height - heightPadding) / itemsPerColumn
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        else if collectionView.tag == 3 {
            let width = thirdView.frame.width
            let height = collectionView.bounds.height
            let itemsPerRow: CGFloat = 1.5
            let widthPadding = 8 * (itemsPerRow + 1)
            let itemsPerColumn: CGFloat = 1
            let heightPadding = 8 * (itemsPerColumn + 1)
            let cellWidth = (width - widthPadding) / itemsPerRow
            let cellHeight = (height - heightPadding) / itemsPerColumn
            
            return CGSize(width: cellWidth, height: cellHeight)
        }
        else if collectionView.tag == 4 {
            let width = fourthView.frame.width
            let height = collectionView.bounds.height
            let itemsPerRow: CGFloat = 1.2
            let widthPadding = 8 * (itemsPerRow + 1)
            let itemsPerColumn: CGFloat = 3
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

