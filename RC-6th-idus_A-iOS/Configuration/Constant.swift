
import Alamofire
import UIKit
//MARK: - Project 전체에서 공통으로 사용하는 값들

struct Constant {
    
    static let BASE_URL = "http://prod.sogogi.shop:9000"
    static let configuration = UIImage.SymbolConfiguration(pointSize: 20, weight: .regular, scale: .default)
    static var USER_JWTTOKEN = ""
    static var USER_ID : Int = 0
    
    static var selectedCategory : Int = 0
    static var selectedProduct : Int = 0
    static var selectedOnlineClass : Int = 0
    static var selectedOfflineClass : Int = 0
    
    //MARK: - 작품 탭
    static var categoryProductList : [CategoryProductList] = []
    static var productReviewList : [ProductReviewList] = []
    static var productDetailInfo : ProductDetailInfoResult = ProductDetailInfoResult(imgUrlList: [], writerId: 0, writerName: "", profileImg: "", rating: 0, countReview: 0, title: "", price: 0, discountRate: 0, finalPrice: 0, shortReviewList: [], countBuyer: 0, deliveryFee: 0, freeAmount: 0, leftAmount: 0, contents: "", reviewList: [], commentList: [], ratingAverage: 0, countAllReview: 0, countAllLike: 0, countFollow: 0, countSupport: 0, countProductLike: 0, like: false)
    static var realTimeProduct : [RealTimeProduct] = []
    static var newProduct : [NewProductsList] = []
    
    //MARK: - 클래스 탭
    static var bestReviewList: [BestReviewList] = []
    static var newOpenClassesList: [NewOpenClassesList] = []
    static var userLikeClassesList: [UserLikeClassesList] = []
    static var allOnlineClassesList: [AllOnlineClassesList] = []
    static var onlineClassDetailResult : OnlineClassDetailResult = OnlineClassDetailResult(videoURL: "", writerID: 0, writerImg: "", writerName: "", categoryName: "", title: "", streaming: false, startingDay: "", level: "", userLike: false, countLike: 0, rating: 0, countReview: 0, onlineClassReviewList: [], contents: "", onlineClassCommentList: [])
    
    
    static var classCategoryList: [ClassCategoryList] = []
    static var nearOfflineClassList: [NearOfflineClassList] = []
    static var newOpenOffLineClassesList: [NewOpenOffLineClassesList] = []
    static var userAddressName : String = ""
    static var offlineClassDatailResult : OfflineClassDetailResult = OfflineClassDetailResult(classImgList: [], categoryName: "", title: "", price: 0, discountRate: 0, finalPrice: 0, level: "", timeSpend: "", maxCapacity: "", userLike: false, countLike: 0, writerID: 0, writerImg: "", writerName: "", contents: "", addressName: "", classReviewsList: [], classCommentList: [])
    
    
    //MARK: - 제품 카테고리 탭
    static var productCategoryList : [ProductCategoryResult] = []
    
    //MARK: - 클래스 카테고리 탭
    static var categoryList: [CategoryList] = []
    static var addressList: [AddressList] = []
   
    //MARK: - 제품 카테고리 디테일 탭
    static var productCaregoryDetailList : [ProductCaregoryDetailResult] = []
    
    //MARK: - 내 정보
    static var myInfoReqResult : MyInfoReqResult = MyInfoReqResult(profileImg: "", grade: "", userName: "", rewardPoint: 0, countCoupon: 0)
    static var myInfoDetailResult : MyInfoDetailResult = MyInfoDetailResult(profileImg: "", userName: "", email: "", birthDay: "", gender: "", phoneNumber: "", addressName: "")
    
    //MARK: - 찜 목록 조회
    static var likeProductResult : [LikeProductResult] = []
    static var likeOnlineClassResult : [LikeOnlineClassGetResult] = []
    static var likeOfflineClassResult : [LikeOfflineClassResult] = []
    
    //MARK: - 주문 옵션 설정
    static var productOptionList : [ProductOptionList] = []
    
    //MARK: - 주문 조회
    static var orderListResult : [OrderListResult] = []
    
    static func clearMemeber(){
        Constant.USER_JWTTOKEN = ""
        Constant.USER_ID = 0
        Constant.selectedCategory = 0
        Constant.selectedProduct = 0
        Constant.categoryProductList.removeAll()
        Constant.productReviewList.removeAll()
        Constant.productDetailInfo = ProductDetailInfoResult(imgUrlList: [], writerId: 0, writerName: "", profileImg: "", rating: 0, countReview: 0, title: "", price: 0, discountRate: 0, finalPrice: 0, shortReviewList: [], countBuyer: 0, deliveryFee: 0, freeAmount: 0, leftAmount: 0, contents: "", reviewList: [], commentList: [], ratingAverage: 0, countAllReview: 0, countAllLike: 0, countFollow: 0, countSupport: 0, countProductLike: 0, like: false)
        Constant.realTimeProduct.removeAll()
        Constant.newProduct.removeAll()
        Constant.bestReviewList.removeAll()
        Constant.newOpenClassesList.removeAll()
        Constant.userLikeClassesList.removeAll()
        Constant.allOnlineClassesList.removeAll()
        Constant.classCategoryList.removeAll()
        Constant.nearOfflineClassList.removeAll()
        Constant.newOpenOffLineClassesList.removeAll()
        Constant.userAddressName = ""
        Constant.productCategoryList.removeAll()
        Constant.categoryList.removeAll()
        Constant.addressList.removeAll()
        Constant.productCaregoryDetailList.removeAll()
        Constant.myInfoReqResult = MyInfoReqResult(profileImg: "", grade: "", userName: "", rewardPoint: 0, countCoupon: 0)
        Constant.myInfoDetailResult =  MyInfoDetailResult(profileImg: "", userName: "", email: "", birthDay: "", gender: "", phoneNumber: "", addressName: "")
        
    }
}
