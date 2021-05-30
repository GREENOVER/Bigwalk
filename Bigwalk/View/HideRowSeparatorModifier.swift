import SwiftUI

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
