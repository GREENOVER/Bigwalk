import Foundation
import Alamofire

// MARK: 서버 통신 및 디코딩을 통한 데이터 정렬
class FetchCampaign: ObservableObject {
    @Published var listData = [Campaign]()
    @Published var totalData = [Campaign]()
    @Published var myData = [Campaign]()
    private let url = "https://app-dev.bigwalk.co.kr:10000/api/campaigns/category/0/story?page=0&size=60"
    private let headers: HTTPHeaders = ["X-AUTH-TOKEN": "eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxODUiLCJyb2xlcyI6WyJST0xFX1VTRVIiXSwiaWF0IjoxNjExNTYzMzgxLCJleHAiOjE3MDYxNzEzODF9._4DPRRFx09yIBVLqwbTGVSuP6vy5fM4UP3vJXszfP4w"]
    
    init() {
        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { [self] response in
                switch response.result {
                case .success(let value):
                    do {
                        let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                        let list = try JSONDecoder().decode([Campaign].self, from: data)
                        self.listData.append(contentsOf: list)
                        
                        let sortData = listData.sorted{$0.ratio < $1.ratio}
                        let undisableData = sortData.filter{$0.dueDate == true}
                        let disableData = sortData.filter{$0.dueDate == false}
                        totalData = undisableData + disableData
                        myData = listData.filter{$0.myInfo.story == true}
                    } catch DecodingError.dataCorrupted(let context) {
                        print("데이터가 손상되었거나 유효하지 않습니다.")
                        print(context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
                    } catch DecodingError.keyNotFound(let codingkey, let context) {
                        print("주어진 키를 찾을수 없습니다.")
                        print(codingkey.intValue ?? Optional(nil)! , codingkey.stringValue , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
                    } catch DecodingError.typeMismatch(let type, let context) {
                        print("주어진 타입과 일치하지 않습니다.")
                        print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
                    } catch DecodingError.valueNotFound(let type, let context) {
                        print("예상하지 않은 null 값이 발견되었습니다.")
                        print(type.self , context.codingPath, context.debugDescription, context.underlyingError ?? "" , separator: "\n")
                    } catch {
                        print("그외 에러가 발생했습니다.")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
    }
}
