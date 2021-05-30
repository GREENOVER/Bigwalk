import SwiftUI
import Kingfisher

struct ContentView: View {
    @State var clickPicker = 1
    @State var clickCheck = 1
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
                Text("내가 참여한 캠페인").frame(maxWidth: .infinity, alignment: .center)
                ScrollView(.horizontal) {
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
                    ForEach(0..<fetch.totalData.count, id: \.self) { i in
                        if clickPicker == fetch.totalData[i].organization {
                            let fetchData = fetch.totalData[i]
                            HStack(spacing: 10) {
                                KFImage(URL(string: fetchData.thumbnail)!)
                                    .resizable()
                                    .frame(width: 100, height: 100).cornerRadius(20)
                                    .opacity(fetchData.dueDate ? 1 : 0.3)
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
                                    Image("contribution")
                                        .resizable()
                                        .frame(width: 60, height: 60)
                                }
                                .opacity(fetchData.dueDate ? 1 : 0)
                            }.hideRowSeparator()
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

// MARK: 리스트 셀 구분선 숨김 처리
extension View {
    func hideRowSeparator(insets: EdgeInsets = .defaultListRowInsets, background: Color = .white) -> some View {
        modifier(HideRowSeparatorModifier(insets: insets, background: background))
    }
}
