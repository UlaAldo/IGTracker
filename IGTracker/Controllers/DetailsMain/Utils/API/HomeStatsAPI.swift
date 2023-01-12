



import Foundation
import Alamofire

class HomeStatsAPI {
    
    static let sample = HomeStatsAPI()
    
   init() {}
    
    func getHomeStats(username: String, completion: @escaping(Result<HomeStatsModel, NetworkError>) -> Void) {
        let url = serverURL + "maindata/"
        let params: Parameters = ["username" : username]
            AF.request(url, parameters: params)
                .validate()
                .responseJSON { dataResponse in
                    switch dataResponse.result {
                    case .success( _):
                        do {
                            guard let jsonData = dataResponse.data else { return }

                            let decoder = JSONDecoder()
                            let responseData = try decoder.decode(HomeStatsModel.self, from: jsonData)
                            completion(.success(responseData))
                           
                            return
                        } catch let error {
                            print(error)
                        
                            return
                        }
                        
                    case .failure:
                        completion(.failure(.decodingError))
                    
                }
        }
    }
    
    enum NetworkError: Error {
        case invalidURL
        case noData
        case decodingError
    }
}
    
