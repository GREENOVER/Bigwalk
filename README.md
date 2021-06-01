# Bigwalk Clone App Project
### 빅워크 기부하기 > 캠페인 화면 및 기능 클론
#### SwiftUI 일부 기능 지원을 위해 iOS 14버전 이후 실행하여야합니다. (iOS 14.4 버전을 권장합니다)
***
## **✍️ 키워드**

- SwiftUI
- Alamofire
- Kingfisher
- Firebase
- SocialLogin (Google, Kakao)
- UnitTest


## **🧑🏻‍💻 구현사항**
- SwiftUI를 사용해 전체적인 UI를 구성하였다.
- 진행중인 캠페인이 최상단으로 정렬되고 캠페인마다 참여율 오름차순으로 정렬하였다.
- 공개형/기업형에 따른 구분을 세그먼트 컨트롤을 사용하여 구현하였다.
- 7개의 카테고리를 HStack으로 스크롤 될 수 있도록 배치하고 각 해당 카테고리 클릭 시 애니메이션이 적용되도록 구현하였다.
- Alamofire로 통신하여 디코딩을 구현하였다.
- Kingfisher로 이미지에 대한 캐싱 처리를 해줘 성능을 향상시켰다.
- 내가 참여한 캠페인과 카테고리는 스크롤바가 보이지 않도록 구현하였다.
- 캠페인 리스트 셀 별 구분선을 없애 상용앱과 동일하게 구현하였다.
- 기부완료 캠페인으 경우 결과 포스트 완료 뱃지를 노출시키도록 ZStack으로 캠페인 썸네일 이미지와 같이 배치하였다.
- 구글과 카카오톡을 통한 로그인 버튼을 구성하여 로그인이 될 수 있도록 구현하였다.
- UI 및 기능 구성 시 최소한의 컴파일 타임이 걸리도록 코드를 구조화하였다.
- 디코딩과 캠페인 정렬 및 필터링에 대한 UnitTest 코드를 구현하고 테스트를 진행하였다.
- SPM과 CocoaPods으로 외부 라이브러리에 대해 관리하였다.

## 🌲 **UI 및 기능 동작**
1. 공개형/기업형 전환에 따른 캠페인 노출   
![InApp_1](https://user-images.githubusercontent.com/72292617/120254180-34ca8c00-c2c4-11eb-9f56-d157cf0af475.gif)
2. 내가 참여한 캠페인 노출 및 스크롤링   
![InApp_2](https://user-images.githubusercontent.com/72292617/120254217-4a3fb600-c2c4-11eb-9b74-7e8a20e14422.gif)
3. 7개의 카테고리에 대한 노출 스크롤링 및 선택 효과 부여   
![InApp_3](https://user-images.githubusercontent.com/72292617/120254256-60e60d00-c2c4-11eb-8588-a0c3e8446365.gif)
4. 캠페인 리스트 노출 및 스크롤링과 통신   
![InApp_4](https://user-images.githubusercontent.com/72292617/120254281-72c7b000-c2c4-11eb-9f2c-d03d093858ae.gif)
5. 구글 로그인   
![GoogleLogin](https://user-images.githubusercontent.com/72292617/120254298-79eebe00-c2c4-11eb-8036-4312c826fed1.gif)
6. 카카오톡 로그인_최초 접속시   
![KakaoLogin_1](https://user-images.githubusercontent.com/72292617/120254309-8115cc00-c2c4-11eb-9eaf-4a744cf8fa19.gif)
7. 카카오톡 로그인_이후 접속시   
![KakaoLogin_2](https://user-images.githubusercontent.com/72292617/120254327-8e32bb00-c2c4-11eb-99df-b285786d95a9.gif)


## **👨‍🔧 트러블 슈팅**

## **🤔 고민한 점**
