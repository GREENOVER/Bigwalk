import SwiftUI
import Kingfisher
import Alamofire

struct ContentView: View {
    @State var clickPicker = 1
    @State var clickCheck = 1
    private let buttonWidth: CGFloat = 70
    private let buttonHeight: CGFloat = 10
    
    @ObservedObject var campaignList: CampaignList = CampaignList(campaigns: totalData)
    @ObservedObject var fetch = FetchCampaign()
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 10) {
                Picker(selection: $clickPicker, label: Text("Picker")) {
                    Text("공개형").tag(1)
                    Text("그룹형").tag(2)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
                ScrollView(.horizontal) {
                    HStack(spacing: 10) {
                        Spacer(minLength: 5)
                        
                        Button(action: {
                            self.clickCheck = 1
                        }) {
                            Text("전체")
                        }.frame(width: buttonWidth, height: buttonHeight)
                        .padding(.all)
                        .background(Color.blue)
                        .cornerRadius(buttonHeight * 2)
                        .foregroundColor(.white)
                        .font(Font.body.bold())
                        
                        Button(action: {
                            self.clickCheck = 2
                        }) {
                            Text("동물")
                        }.frame(width: buttonWidth, height: buttonHeight)
                        .padding(.all)
                        .background(Color.white)
                        .cornerRadius(buttonHeight * 2)
                        .foregroundColor(.gray)
                        .font(Font.body.bold())
                        
                        Button(action: {
                            self.clickCheck = 3
                        }) {
                            Text("아이")
                        }.frame(width: buttonWidth, height: buttonHeight)
                        .padding(.all)
                        .background(Color.white)
                        .cornerRadius(buttonHeight * 2)
                        .foregroundColor(.gray)
                        .font(Font.body.bold())
                        
                        Button(action: {
                            self.clickCheck = 4
                        }) {
                            Text("노인")
                        }.frame(width: buttonWidth, height: buttonHeight)
                        .padding(.all)
                        .background(Color.white)
                        .cornerRadius(buttonHeight * 2)
                        .foregroundColor(.gray)
                        .font(Font.body.bold())
                        
                        Button(action: {
                            self.clickCheck = 5
                        }) {
                            Text("환경")
                        }.frame(width: buttonWidth, height: buttonHeight)
                        .padding(.all)
                        .background(Color.white)
                        .cornerRadius(buttonHeight * 2)
                        .foregroundColor(.gray)
                        .font(Font.body.bold())
                        
                        Button(action: {
                            self.clickCheck = 6
                        }) {
                            Text("장애인")
                        }.frame(width: buttonWidth, height: buttonHeight)
                        .padding(.all)
                        .background(Color.white)
                        .cornerRadius(buttonHeight * 2)
                        .foregroundColor(.gray)
                        .font(Font.body.bold())
                        
                        Button(action: {
                            self.clickCheck = 7
                        }) {
                            Text("지구촌")
                        }.frame(width: buttonWidth, height: buttonHeight)
                        .padding(.all)
                        .background(Color.white)
                        .cornerRadius(buttonHeight * 2)
                        .foregroundColor(.gray)
                        .font(Font.body.bold())
                        
                        Spacer(minLength: 5)
                    }
                }
                
                List {
                    ForEach(0..<fetch.listData.count, id: \.self) { i in
                        if clickPicker == fetch.listData[i].organization {
                            HStack(spacing: 10) {
                                KFImage(URL(string: fetch.listData[i].thumbnail)!)
                                    .resizable()
                                    .frame(width: 100, height: 100).cornerRadius(20)
                                    .opacity(fetch.listData[i].dueDate ? 1 : 0.3)
                                VStack(alignment: .leading) {
                                    Text(fetch.listData[i].title)
                                        .font(.system(size: 20, weight: .bold))
                                        .opacity(fetch.listData[i].dueDate ? 1 : 0.3)
                                    Text(fetch.listData[i].promoterInfo.name)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .bold))
                                        .opacity(fetch.listData[i].dueDate ? 1 : 0.3)
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
                                        Text(fetch.listData[i].ratioStr)
                                            .foregroundColor(.blue)
                                            .font(.system(size: 15, weight: .bold))
                                        Spacer()
                                        Text(fetch.listData[i].state.0)
                                            .foregroundColor(fetch.listData[i].state.1)
                                            .font(.system(size: 15, weight: .bold))
                                    }
                                    ProgressView(value: (fetch.listData[i].progressRatio))
                                }
                                Button(action: {print("기부")}){
                                    Image("contribution")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                }
                                .opacity(fetch.listData[i].dueDate ? 1 : 0)
                            }
                        }
                    }
                }
            }
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ContentView()
//                .previewDevice("iPhone 11")
//        }
//    }
//}

class CampaignList: ObservableObject {
    @Published var campaigns: [Campaign]
    
    init(campaigns: [Campaign] = []) {
        self.campaigns = campaigns
    }
}

class FetchCampaign: ObservableObject {
    @Published var listData = [Campaign]()
    private let url = "https://app-dev.bigwalk.co.kr:10000/api/campaigns/category/0/story?page=0&size=60"
    private let headers: HTTPHeaders = ["X-AUTH-TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxODUiLCJyb2xlcyI6WyJST0xFX1VTRVIiXSwiaWF0IjoxNjExNTYzMzgxLCJleHAiOjE3MDYxNzEzODF9._4DPRRFx09yIBVLqwbTGVSuP6vy5fM4UP3vJXszfP4w"]

    let fetchGroup = DispatchGroup()
    
    init() {
        fetchGroup.enter()
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { [self] response in
                switch response.result {
                case .success(let value):
                    print(value)
                    do {
                        let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let list = try JSONDecoder().decode([Campaign].self, from: data)
                        self.listData.append(contentsOf: list)
                    } catch {
                    }
                case .failure(let error):
                    break
                }
                self.fetchGroup.leave()
            }
    }
}
