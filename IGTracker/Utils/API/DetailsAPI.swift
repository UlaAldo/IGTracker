




import Foundation
import Alamofire


class DetailsAPI {
    
    static let shared = DetailsAPI()
    
    private init() {}
    
    
    func getFollowers(username: String, url: String, completion: @escaping(Result<[Followers], NetworkError>) -> Void) {
        let url = serverURL + url
        let params: Parameters = ["username" : username]
            AF.request(url, parameters: params)
                .validate()
                .responseJSON { dataResponse in
                    switch dataResponse.result {
                    case .success( _):
                        do {
                            guard let jsonData = dataResponse.data else { return }

                            let decoder = JSONDecoder()
                            let responseData = try decoder.decode([Followers].self, from: jsonData)
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
        
        func fetchAvatar(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void) {
            guard let url = URL(string: url ?? "") else {
                completion(.failure(.invalidURL))
                return
            }
            DispatchQueue.global().async {
                guard let imageData = try? Data(contentsOf: url) else {
                    completion(.failure(.noData))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(imageData))
                }
            }
        }
  
    
    func getDeletedCommentsLikes(completion: @escaping(Result<DeletedPost, NetworkError>) -> Void) {
        let url = serverURL + "/deleted_likes_and_comments/"
            AF.request(url)
                .validate()
                .responseJSON { dataResponse in

                    switch dataResponse.result {
                    case .success( _):
                        do {
                            guard let jsonData = dataResponse.data else { return }
                            let decoder = JSONDecoder()
                            let responseData = try decoder.decode(DeletedPost.self, from: jsonData)
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
    
    func getTopLikePost(durationFilter: DurationFilter, completion: @escaping(Result<[TopLikePosts], NetworkError>) -> Void) {
        var url = serverURL + "/top_liked_post/"
        if durationFilter != .allTime {
            url += "?filter=" + durationFilter.rawValue
        }
            AF.request(url)
                .validate()
                .responseJSON { dataResponse in
                    switch dataResponse.result {
                    case .success( _):
                        do {
                            guard let jsonData = dataResponse.data else { return }

                            let decoder = JSONDecoder()
                            let responseData = try decoder.decode([TopLikePosts].self, from: jsonData)
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
    
    func getTopCommentPost(durationFilter: DurationFilter ,completion: @escaping(Result<[TopCommentPosts], NetworkError>) -> Void) {
        var url = serverURL + "/top_commented_post/"
        if durationFilter != .allTime {
            url += "?filter=" + durationFilter.rawValue
        }
            AF.request(url)
                .validate()
                .responseJSON { dataResponse in
                    switch dataResponse.result {
                    case .success( _):
                        do {
                            guard let jsonData = dataResponse.data else { return }

                            let decoder = JSONDecoder()
                            let responseData = try decoder.decode([TopCommentPosts].self, from: jsonData)
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
