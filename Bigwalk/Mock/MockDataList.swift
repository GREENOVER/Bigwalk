import Foundation

// MARK: Mock 데이터를 통한 정렬 및 초기화
class MockDataList: ObservableObject {
    @Published var campaigns: [Campaign]
    
    init() {
        let campaignData: [Campaign] = JSONDecode.shared.loadJSON("CampaignMock.json")!
        let sortData = campaignData.sorted{$0.ratio < $1.ratio}
        let undisableData = sortData.filter{$0.dueDate == true}
        let disableData = sortData.filter{$0.dueDate == false}
        let totalData = undisableData + disableData
        self.campaigns = totalData
    }
}
