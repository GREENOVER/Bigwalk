import Foundation

var campaignData: [Campaign] = JSONDecode.shared.loadJSON("CampaignMock.json")!
var sortData = campaignData.sorted{$0.ratio < $1.ratio}

struct Campaign: Decodable {
    let thumbnail: String
    let title: String
    let ratio: Int
    private let endDate: String
    let promoterInfo: Promoter
    let myInfo: My
    private let organizationsInfo: [Organizations]
    
    struct Promoter: Decodable {
        let name: String
    }
    
    struct My: Decodable {
        let story: Bool
    }
    
    struct Organizations: Decodable {
        let id: Int
    }
    
    enum CodingKeys: String, CodingKey {
        case thumbnail = "smallListThumbnailImagePath"
        case title = "name"
        case promoterInfo = "campaignPromoter"
        case myInfo = "my"
        case organizationsInfo = "organizations"
        case ratio, endDate
    }
    
    var dueDate: Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let end: Date = dateFormatter.date(from: endDate)!
        let now = Date()
        
        if end.timeIntervalSince(now) > 0 {
            return true
        } else {
            return false
        }
    }
    
    var organization: Int {
        if organizationsInfo.isEmpty {
            return 1
        } else {
            return 2
        }
    }
    
    var progressRatio: Double {
        if ratio == 0 {
            return 0.0
        } else {
            let progress = (Double(ratio) / 100.0)
            if progress >= 1.0 {
                return 1.0
            } else {
                return progress
            }
        }
    }
    
    var ratioStr: String {
        return String("\(ratio)%")
    }
    
    var state: String {
        if dueDate == true {
            return "진행중"
        } else if dueDate == false && myInfo.story == false {
            return "종료"
        } else {
            return "기부완료"
        }
    }
}
