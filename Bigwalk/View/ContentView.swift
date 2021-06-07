import SwiftUI
import Kingfisher
import KakaoSDKAuth
import KakaoSDKUser
import GoogleSignIn

struct ContentView: View {
    @State var clickPicker = 1
    @State var clickCheck: String = Category.total.title
    private let buttonWidth: CGFloat = 70
    private let buttonHeight: CGFloat = 10
    
    @ObservedObject var fetch = FetchCampaign()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                Picker(selection: $clickPicker, label: Text("Picker")) {
                    Text("공개형").tag(1)
                    Text("그룹형").tag(2)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                Text("내가 참여한 캠페인")
                    .font(Font.body.bold())
                    .frame(maxWidth: .infinity, alignment: .center)
                ScrollView(.horizontal, showsIndicators: false) {
                    if fetch.myData.isEmpty {
                        ProgressView().frame(width: UIScreen.main.bounds.width, alignment: .center)
                    }
                    HStack(spacing: 10) {
                        Spacer(minLength: 5)
                        ForEach(0..<fetch.myData.count, id: \.self) { i in
                            let myData = fetch.myData[i]
                            VStack {
                                KFImage(URL(string: myData.thumbnail)!)
                                    .resizable()
                                    .frame(width: 100, height: 100).cornerRadius(20)
                                    .opacity(myData.dueDate ? 1 : 0.3)
                                Text(fetch.myData[i].title)
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .bold))
                            }
                        }
                    }
                }
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        Spacer(minLength: 5)
                        
                        ForEach(Category.allCases, id: \.self) { category in
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
                        }
                        
                        Spacer(minLength: 5)
                    }
                }
                
                if fetch.totalData.isEmpty {
                    ProgressView().frame(width: geometry.size.width, height: geometry.size.height * 0.7, alignment: .center)
                }
                
                List {
                    ForEach(0..<fetch.totalData.count, id: \.self) { i in
                        if clickPicker == fetch.totalData[i].organization {
                            let fetchData = fetch.totalData[i]
                            HStack(spacing: 10) {
                                ZStack {
                                    KFImage(URL(string: fetchData.thumbnail)!)
                                        .resizable()
                                        .frame(width: 100, height: 100).cornerRadius(20)
                                        .opacity(fetchData.dueDate ? 1 : 0.3)
                                    Image("iconDonationCompleted")
                                        .resizable()
                                        .frame(width: 100, height: 100).cornerRadius(20)
                                        .opacity(fetchData.myInfo.story ? 1 : 0)
                                }
                                VStack(alignment: .leading) {
                                    Text(fetchData.title)
                                        .font(.system(size: 20, weight: .bold))
                                        .opacity(fetchData.dueDate ? 1 : 0.3)
                                    Text(fetchData.promoterInfo.name)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .bold))
                                        .opacity(fetchData.dueDate ? 1 : 0.3)
                                    if clickPicker == 1  {
                                        Button("공개형") {
                                        }
                                        .font(.system(size: 10, weight: .bold))
                                        .frame(width: 40, height: 15)
                                        .background(Color.green)
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                    } else {
                                        Button("그룹형") {
                                        }
                                        .font(.system(size: 10, weight: .bold))
                                        .frame(width: 40, height: 15)
                                        .background(Color.yellow)
                                        .cornerRadius(10)
                                        .foregroundColor(.white)
                                    }
                                    HStack {
                                        Text(fetchData.ratioStr)
                                            .foregroundColor(.blue)
                                            .font(.system(size: 15, weight: .bold))
                                        Spacer()
                                        Text(fetchData.state.0)
                                            .foregroundColor(fetchData.state.1)
                                            .font(.system(size: 15, weight: .bold))
                                    }
                                    ProgressView(value: (fetchData.progressRatio))
                                }
                                Button(action: {}){
                                    Image("btnDonationMedN")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                }
                                .opacity(fetchData.dueDate ? 1 : 0)
                            }.hideRowSeparator()
                        }
                    }
                }
                HStack(spacing: 20) {
                    Button(action: GoogleLogin.attemptLoginGoogle,label: {
                        Image("google")
                            .resizable()
                            .frame(width: 20, height: 20)
                    })
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color.white)
                    .cornerRadius(8.0)
                    .shadow(radius: 4.0)
                    Button(action : {
                        if (UserApi.isKakaoTalkLoginAvailable()) {
                            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                                print(oauthToken?.accessToken as Any)
                                print(error as Any)
                            }
                        }else{
                            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                                print(oauthToken?.accessToken as Any)
                                print(error as Any)
                            }
                        }
                    }){
                        Image("kakao")
                            .resizable()
                            .frame(width: 20, height: 20)
                        
                    }
                    .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .background(Color.yellow)
                    .cornerRadius(8.0)
                    .shadow(radius: 4.0)
                    .onOpenURL(perform: { url in
                        if (AuthApi.isKakaoTalkLoginUrl(url)) {
                            _ = AuthController.handleOpenUrl(url: url)
                        }
                    })
                }
            }
        }
    }
}

// MARK: 미리보기뷰
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")
        }
    }
}

// MARK: 리스트 셀 구분선 숨김 처리
extension View {
    func hideRowSeparator(insets: EdgeInsets = .defaultListRowInsets, background: Color = .white) -> some View {
        modifier(HideRowSeparatorModifier(insets: insets, background: background))
    }
}

// MARK: 구글 로그인
struct GoogleLogin: UIViewRepresentable {
    
    func makeUIView(context: UIViewRepresentableContext<GoogleLogin>) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<GoogleLogin>) {
    }
    
    static func attemptLoginGoogle(){
        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
        GIDSignIn.sharedInstance()?.signIn()
    }
}

// MARK: 데이터 통신 인디케이터
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
