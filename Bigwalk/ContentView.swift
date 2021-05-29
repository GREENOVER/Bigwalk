import SwiftUI
import Kingfisher

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
                    ForEach(0..<campaignList.campaigns.count) { i in
                        if clickPicker == campaignList.campaigns[i].organization {
                            HStack(spacing: 10) {
                                KFImage(URL(string: campaignList.campaigns[i].thumbnail)!)
                                    .resizable()
                                    .frame(width: 100, height: 100).cornerRadius(20)
                                    .opacity(campaignList.campaigns[i].dueDate ? 0.3 : 1)
                                VStack(alignment: .leading) {
                                    Text(campaignList.campaigns[i].title)
                                        .font(.system(size: 20, weight: .bold))
                                        .opacity(campaignList.campaigns[i].dueDate ? 0.3 : 1)
                                    Text(campaignList.campaigns[i].promoterInfo.name)
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .bold))
                                        .opacity(campaignList.campaigns[i].dueDate ? 0.3 : 1)
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
                                        Text(campaignList.campaigns[i].ratioStr)
                                            .foregroundColor(.blue)
                                            .font(.system(size: 15, weight: .bold))
                                        Spacer()
                                        Text(campaignList.campaigns[i].state)
                                            .foregroundColor(.blue)
                                            .font(.system(size: 15, weight: .bold))
                                    }
                                    ProgressView(value: (campaignList.campaigns[i].progressRatio))
                                }
                                Button(action: {print("기부")}){
                                    Image("contribution")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                }
                                .opacity(campaignList.campaigns[i].dueDate ? 0 : 1)
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
