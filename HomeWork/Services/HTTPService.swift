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
    func getRequest<Response: Decodable>(
        urlString: String,
        responseType: Response.Type,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        guard let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                completion(.failure(APIError.invalidURL(url: urlString)))
            }
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                let code = (response as? HTTPURLResponse)?.statusCode ?? -1
                let errorMessage = error?.localizedDescription ?? "Unknown error"
                DispatchQueue.main.async {
                    completion(.failure(APIError.requestFailed(url: urlString, code: code, message: errorMessage)))
                }
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                let errorMessage = error.localizedDescription
                DispatchQueue.main.async {
                    completion(.failure(APIError.invalidData(url: urlString, message: errorMessage)))
                }
            }
        }.resume()
    }
}

// MARK: APIError
enum APIError: Error {
    case invalidURL(url: String)
    case requestFailed(url: String, code: Int, message: String)
    case invalidData(url: String, message: String)
}
