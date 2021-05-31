import Foundation

enum Category: String, CaseIterable {
    case total
    case animal
    case young
    case old
    case environment
    case disable
    case planet

    var title: String {
        switch self {
        case .total:
            return "전체"
        case .animal:
            return "동물"
        case .young:
            return "아이"
        case .old:
            return "노인"
        case .environment:
            return "환경"
        case .disable:
            return "장애인"
        case .planet:
            return "지구촌"
        }
    }
}
