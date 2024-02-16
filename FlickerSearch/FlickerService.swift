//
//  FlickerService.swift
//  FlickerSearch
//
//  Created by shiva on 2/15/24.
//

import Foundation

class FlickerService {
    
    let flickerDataURL = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&nojsoncallback=1&tags="
    
    func fetchFlickerData(searchText: String, completion: @escaping (Result<FlickerData, Error>) -> Void) {
        let input = searchText.replacingOccurrences(of: " ", with: "")
        
        let url = URL(string: flickerDataURL+input)

        let dataTask = URLSession.shared.dataTask(with: URLRequest(url: url!)) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "AppErrorDomain",
                                            code: -1,
                                            userInfo: [NSLocalizedDescriptionKey: "Unable to retrieve given data"])))
                return
            }

            do {
                let decoder = JSONDecoder()
                let fetchedData = try decoder.decode(FlickerData.self, from: data)
                completion(.success(fetchedData))
            } catch {
                completion(.failure(error))
            }
        }

        dataTask.resume()
    }
}
