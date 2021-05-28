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
        dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let date = Date()
        let current = dateFormatter.string(from: date)
        let currentDate = dateFormatter.date(from: current)
        
        if (dateFormatter.date(from: endDate)?.timeIntervalSince(currentDate!))! < 0 {
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
}
