# Bigwalk Clone App Project
### 빅워크 기부하기 > 캠페인 화면 및 기능 클론
#### SwiftUI 일부 기능 지원을 위해 iOS 14버전 이후 실행하여야합니다. (iOS 14.4 버전을 권장합니다)
#### 각 디바이스별 사이즈에 대한 오토레이아웃 지원이 가능하나 iPhone 11 버전 크기가 심미적으로 보기 좋습니다.
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
8. 데이터 통신 시 인디케이터 노출
![indicator](https://user-images.githubusercontent.com/72292617/120956131-dd2d9400-c78d-11eb-80db-77c91f1bcfce.gif)


## **👨‍🔧 트러블 슈팅**
### "SwiftUI List의 구분선을 없애는 방법"
- 간단하게 separatorStyle = .none을 주어 구현을 시도하였는데 되지 않아 찾아보니 SwiftUI가 아직 완벽하게 지원되지 않아 되지 않을경우도 있었다.
- 구분선을 없애주기 위해 HideRowSeparatorModifier라는 구조체 타입을 생성하여 그 안에서 구분선을 없애고 패딩과 엣지를 설정하여 적용하였다.
- ```swift
  // MARK: 리스트 셀 구분선 숨김 구조체
  struct HideRowSeparatorModifier: ViewModifier {
    static let defaultListRowHeight: CGFloat = 20
    var insets: EdgeInsets
    var background: Color
    
    init(insets: EdgeInsets, background: Color) {
        self.insets = insets
        var alpha: CGFloat = 0
        UIColor(background).getWhite(nil, alpha: &alpha)
        assert(alpha == 1)
        self.background = background
    }
    
    func body(content: Content) -> some View {
        content
            .padding(insets)
            .frame( minWidth: 0, maxWidth: .infinity, minHeight: Self.defaultListRowHeight, alignment: .leading )
            .listRowInsets(EdgeInsets())
            .background(background)
    }
  }
  // MARK: 셀 마진 엣지 설정
  extension EdgeInsets {
      static let defaultListRowInsets = Self(top: 10, leading: 10, bottom: 10, trailing: 10)
  }
  ```
### "SwiftUI 요소 배치 시 순차적용 되는 문제"
- SwiftUI에서는 UI 요소를 배치하고 옵션을 줄때 UIKit과는 다르게 적용한 순서대로 옵션이 설정되어 고려하여 옵션을 적용하였다.
## **🤔 고민한 점**
### "좀 더 빠른 이미지 처리 및 캐싱"
- 통신 후 이미지에 대한 처리를 더 빠르게 해주기 위해 킹피셔 라이브러리를 통해 이미지 캐싱 및 처리를 구현하였다.
  ```swift
  KFImage(URL(string: fetchData.thumbnail)!)
                                        .resizable()
                                        .frame(width: 100, height: 100).cornerRadius(20)
                                        .opacity(fetchData.dueDate ? 1 : 0.3)
  ```
 ### "카테고리 영역 별 클릭 시 선택 효과가 부여되도록 구현하기"
 - 카테고리 버튼 생성 하여 액션을 주어 선택 시 효과를 부여할 수 있도록 해당 카테고리 별 클릭 변수를 두어 액션을 취해주도록 구현하였다.
  ```swift
   if category.title == clickCheck {
                                Button(action: {
                                    self.clickCheck = category.title
                                }) {
                                    Text("\(category.title)")
                                }.frame(width: buttonWidth, height: buttonHeight)
                                .padding(.all)
                                .background(Color.blue)
                                .cornerRadius(buttonHeight * 2)
                                .foregroundColor(.white)
                                .font(Font.body.bold())
                            } else {
                                Button(action: {
                                    self.clickCheck = category.title
                                }) {
                                    Text("\(category.title)")
                                }.frame(width: buttonWidth, height: buttonHeight)
                                .padding(.all)
                                .background(Color.white)
                                .cornerRadius(buttonHeight * 2)
                                .foregroundColor(.gray)
                                .font(Font.body.bold())
                            }
  ```
### "SNS 로그인 설정에 대한 앱 딜리게이트 파일 생성 및 적용"
- SwiftUI 앱 사이클로 프로젝트 진행 시 앱 딜리게이트 파일을 직접 생성하여 구현하여야되었다.
- 앱 딜리게이트 파일을 생성하여 앱 설정을 구현하고 뷰 로드 시 사용되도록 구현하였다.
  ```swift
  class AppDelegate: NSObject, UIApplicationDelegate, GIDSignInDelegate{
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        KakaoSDKCommon.initSDK(appKey: "9d97f6c41c56b1564f7fad8eb23c59ab", loggingEnable:false)
        
        FirebaseApp.configure()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
            return AuthController.handleOpenUrl(url: url, options: options)
        }
        
        return GIDSignIn.sharedInstance().handle(url)
    }
    
    @available(iOS 9.0, *)
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil {
            return
        }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential){
            (user, error) in
            if error != nil {
                return
            }
        }
    }
  }
  ```
### "정렬 및 필터링에 대한 고민"
- 캠페인 데이터를 정렬해주기 위해 고차함수를 사용하여 사이드 이펙트 없도록 구현하였다.
- 통신 후 디코딩을 통해 객체를 생성하는 과정에서 sorted로 참여율 순으로 정렬한다.
- 또한 진행중 캠페인이 최상단에 위치하게끔 만료일의 여부를 가지고 두개의 배열을 생성한뒤 합쳐주었다.
  ```swift
  let sortData = listData.sorted{$0.ratio < $1.ratio}
  let undisableData = sortData.filter{$0.dueDate == true}
  let disableData = sortData.filter{$0.dueDate == false}
  totalData = undisableData + disableData
  ```
### "통신을 비동기적으로 처리하기"
- 통신을 한 후 화면이 업데이트 되도록 하기 위해 @ObservedObject 어노테이션을 사용하여 통신 디코딩 데이터에 대한 객체를 생성하고 리스트로 화면 구성 시 고유 캠페인 별 id값을 사용하여 통신 후 화면이 다시 그려져 정상적으로 보이도록 구현하였다.
- UIKit에서 구현한다면 prepareForReuse와 같은 기능을 SwiftUI에서는 옵저버 패턴을 통해 간단히 구현할 수 있었다.
  ```swift
  @ObservedObject var fetch = FetchCampaign()
  ForEach(0..<fetch.totalData.count, id: \.self) { i in
  ...
  }
  ```
### "데이터 통신 시 로딩중임을 사용자에게 알려주기"
- 데이터 통신 과정에서 빈 화면이 아닌 로딩중이라는 통신에 대한 인디케이터 애니메이션을 구현하였다.
- fetch 데이터가 비어있는 조건문을 가정하여 비어있으면 인디케이터 노출, 통신 완료 시 인디케이터 애니메이션 동작이 멈추고 데이터가 노출되도로 구현하였다.
- UIKit의 ActivityIndicator를 사용하기 위해 UIViewRepresentable 프로토콜을 채택하여 인디케이터 구조체를 만들고 사용하였다.
  ```swift
  struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
  }
  ```
  ```swift
  if fetch.totalData.isEmpty {
      ProgressView().frame(width: geometry.size.width, height: geometry.size.height * 0.7, alignment: .center)
  }
  ```
                       
