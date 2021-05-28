import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Picker(selection: .constant(1), label: Text("Picker")) {
                    Text("공개형").tag(1)
                    Text("기업형").tag(2)
                }.pickerStyle(SegmentedPickerStyle()).padding(.horizontal)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
