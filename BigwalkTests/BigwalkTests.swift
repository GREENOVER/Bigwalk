import XCTest
@testable import Bigwalk

class BigwalkTests: XCTestCase {
    
    func testDecodeMockData() throws {
        let data: [Campaign] = JSONDecode.shared.loadJSON("CampaignMock.json")!
        XCTAssertEqual(data[0].title, "챌린지 테스트")
        XCTAssertEqual(data[0].ratio, 0)
        XCTAssertEqual(data[59].title, "나다의 #일일일만보")
        XCTAssertEqual(data[59].ratio, 2956)
    }
    
    func testArrayCampaign() throws {
        let data: [Campaign] = JSONDecode.shared.loadJSON("CampaignMock.json")!
        let ratioData = data.sorted{$0.ratio < $1.ratio}
        XCTAssertEqual(ratioData[0].ratio, 0)
        XCTAssertEqual(ratioData[59].ratio, 2956)
    }
    
    func testFilteringCampaign() throws {
        let data: [Campaign] = JSONDecode.shared.loadJSON("CampaignMock.json")!
        let openData = data.filter{$0.organization == 1}
        let groupData = data.filter{$0.organization == 2}
        
        for i in openData {
           XCTAssertEqual(i.organization, 1)
        }
        for i in groupData {
           XCTAssertEqual(i.organization, 2)
        }
    }

}
