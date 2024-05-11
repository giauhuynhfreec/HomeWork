//
//  HTTPService.swift
//  HomeWork
//
//  Created by Giau Huynh on 10/05/2024.
//

import Foundation

protocol HTTPServiceProtocol {
    func getRequest<Response: Decodable>(
        urlString: String,
        responseType: Response.Type,
        completion: @escaping (Result<Response, Error>) -> Void
    )
}

final class HTTPService: HTTPServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func getRequest<Response: Decodable>(
        urlString: String,
        responseType: Response.Type,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        // invalidURL
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(APIError.invalidURL(url: urlString)))
            }
            return
        }
        
        session.dataTask(with: url) { data, response, error in
            // requestFailed
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      DispatchQueue.main.async {
                          completion(.failure(APIError.requestFailed(
                            url: urlString,
                            code: (response as? HTTPURLResponse)?.statusCode ?? -1,
                            message: error?.localizedDescription ?? "Unknown error"
                          )))
                      }
                      return
                  }
            
            // noData
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.failure(APIError.noData(url: urlString)))
                }
                return
            }
            
            // decode
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(APIError.invalidData(
                        url: urlString,
                        message: error.localizedDescription
                    )))
                }
            }
        }.resume()
    }
}

// MARK: APIError
enum APIError: Error {
    case invalidURL(url: String)
    case requestFailed(url: String, code: Int, message: String)
    case noData(url: String)
    case invalidData(url: String, message: String)
}
