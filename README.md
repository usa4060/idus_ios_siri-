# idus_A_iOS_siri 개발일지

---
<br>

# 2022-06-25 진행상황


- 스토리보드 template 구성 및 README.md 생성
- Launch Screen 구현
</br></br>
# 2022-06-26 진행상황

- 로그인 대기 화면 UI구현
- Bottom Navigation 화면전환 설정 완료
- '작품'탭 UI 구성
  - XLpagertabstrip을 이용한 상단 탭 분리 완료 (오류 Fix)
    - 오류내용 : XLpagertabstrip의 setting을 설정하는 func를 super.ViewDidLoad() 이후에 실행되게 만들어서 UI가 제대로 동작 안함
    - 오류해결 : super.ViewDidLoad() 이전에 setting func를 실행하여 정상 작동</br>
  <img width="20%" src="https://user-images.githubusercontent.com/80234027/176075848-aa415d1c-9632-4060-b3a2-5f483fa6b574.png"/>
  <img width="20%" src="https://user-images.githubusercontent.com/80234027/175838125-ccc3fd46-1149-4a25-a71a-1ec999734129.png"/>
  </br></br>

# 2022-06-27 진행상황

- 이메일 회원가입 페이지 UI 구현
- 기존회원 로그인 페이지 UI 구현
- 홈/작품/투데이-배너 자동 paging 구현
- 홈/작품/투데이-세부 카테고리 페이지 UI 구현 (오류 Fix)
    - 오류내용 : 동시에 2개의 CollectionView를 다루는 과정에서, `scrollViewDidScroll(_ scrollView:)` 를 이용하여 특정 CollectionView에만 동작하게 해야하는 이슈 발생
    - 오류해결 : CollectionView는 ScrollView를 상속하고 있기 때문에 `if scrollView == secondCollectionView` 를 통해 특정 collectionView에만 반응하도록 하여 해결</br>
  <img width="20%" src="https://user-images.githubusercontent.com/80234027/176077264-cd0943e5-b6a6-411c-b685-d119a5c066fa.png"/>
  <img width="20%" src="https://user-images.githubusercontent.com/80234027/176077295-c30405f9-8764-490f-86d5-646e8fdf501e.png"/>
  <img width="20%" src="https://user-images.githubusercontent.com/80234027/176077304-70085e9d-57ee-4ece-abd1-9544d7f77e0b.png"/>
  <img width="20%" src="https://user-images.githubusercontent.com/80234027/176077314-37a20971-c1f7-42c5-bd17-365d662a21c1.png"/>
  </br></br>
  
# 2022-06-28 진행상황

- 회원가입 API연결
    - 오류발견 및 해결 중,,,

# 2022-06-29 진행상황 (1차 피드백)

- 버그 Fix
    1. SSL오류로 연결 불가
        - https 대신 http로 연결되는 것을 확인하여 서버에 수정 요청
    2. `AF.request()` 사용 시  `header:`  에 아래의 값을  파라미터로 넣어줘야 함. (특정 header가 없을 때 default값)
        
        ```swift
        var headers: HTTPHeaders = [
        
        "Content-Type":"application/json",
        
        "Accept": "application/json"
        
        ]
        ```
        
    3. `AF.request()` 사용 시 `parameters:` 에 `Parameters` 타입의 Dictionary값을 넣어줘야 함
        
        → 일반적인 구조체 (struct)를 그대로 넣어주면 Error
        
    4. AF.request()의 내부 파라미터로 
        
        `"\(Constant.BASE_URL)/users", method: .post, parameters: param ,encoding: JSONEncoding.default, headers: headers` 값이 순서대로 들어가야 함.
       
# 2022-06-30 진행상황

- 로그인 API연결
  - 회원가입 & 로그인 오류 Fix
- 홈/투데이 UI작업 코드화 완료 & 오류 Fix
  - xib 최대한 자제하고 코드로 전환

# 2022-07-01 진행상황

- 모든품목 조회 API모델 & DataManager 구현

# 2022-07-02 진행상황

- 투데이 전체 UI 구현
- 전체품목 API연결 및 UI
