import SwiftUI

struct ContentView: View {
    @State var clickPicker = 1
    @State var clickCheck = 1
    private let buttonWidth: CGFloat = 70
    private let buttonHeight: CGFloat = 10
    
    
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
