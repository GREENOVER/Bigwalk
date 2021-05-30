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

}
