//
//  MockHTTPService.swift
//  HomeWorkTests
//
//  Created by Giau Huynh on 11/05/2024.
//

import Foundation
@testable import HomeWork

class MockHTTPService: HTTPServiceProtocol {
    var mockResult: Any?

    func getRequest<Response: Decodable>(
        urlString: String,
        responseType: Response.Type,
        completion: @escaping (Result<Response, Error>) -> Void
    ) {
        if let mockResult = mockResult as? Result<Response, Error> {
            completion(mockResult)
        } else{
            completion(.failure(APIError.requestFailed(
                url: urlString,
                code: 400,
                message: "Invalid mock"
            )))
        }
    }
}
