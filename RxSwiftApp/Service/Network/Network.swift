import UIKit
//Работа с сетью
class NetworkService {
    
    static let shared : NetworkService = NetworkService()
    
    func loadData<T : Decodable>(url : String,complition: @escaping (Result<T?, Error>) -> Void) {
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { data, _, error  in
            if let error = error {
                complition(.failure(error))
                return
            }
            do {
                let result = try JSONDecoder().decode(T.self, from: data!)
                complition(.success(result))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}
