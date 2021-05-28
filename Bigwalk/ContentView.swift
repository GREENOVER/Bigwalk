import SwiftUI

struct ContentView: View {
    @State var clickPicker = 1
    @State var clickCheck = 1
    private let buttonWidth: CGFloat = 70
    private let buttonHeight: CGFloat = 10
    
    @ObservedObject var campaignList: CampaignList = CampaignList(campaigns: sortData)
    
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
                    HStack(spacing: 10) {
                        Image("thumbnail").resizable().frame(width: 100, height: 100)
                        VStack(alignment: .leading) {
                            Text("세상에서 제일 쉬운 나눔").font(.system(size: 20, weight: .bold))
                            Text("네패스 기업문화팀").foregroundColor(.gray)
                                .font(.system(size: 15, weight: .bold))
                            Button("공개형") {
                            }.font(.system(size: 10, weight: .bold))
                            .frame(width: 40, height: 15)
                            .background(Color.green)
                            .cornerRadius(10)
                            .foregroundColor(.white)
                            HStack {
                                Text("90%").foregroundColor(.blue)
                                    .font(.system(size: 15, weight: .bold))
                                Spacer()
                                Text("진행중").foregroundColor(.blue)
                                    .font(.system(size: 15, weight: .bold))
                            }
                            ProgressView(value: 0.9)
                        }
                        Button(action: {print("기부")}){
                            Image("contribution")
                                .resizable()
                                .frame(width: 60, height: 60)
                        }
                    }
                    ForEach(0..<campaignList.campaigns.count) { i in
                        VStack {
                            Text(campaignList.campaigns[i].title)
                            Text(campaignList.campaigns[i].thumbnail)
                            Text(campaignList.campaigns[i].promoterInfo.name)
                            Text(String(campaignList.campaigns[i].ratio))
                            Text(String(campaignList.campaigns[i].myInfo.story))
                            Text(String(campaignList.campaigns[i].organization))
                            Text(String(campaignList.campaigns[0].dueDate))
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .previewDevice("iPhone 11")
        }
    }
}

class CampaignList: ObservableObject {
    @Published var campaigns: [Campaign]
    
    init(campaigns: [Campaign] = []) {
        self.campaigns = campaigns
    }
}
