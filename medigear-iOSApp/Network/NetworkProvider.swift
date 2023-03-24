//
//  NetworkProvider.swift
//  medigear-iOSApp
//
//  Created by Gabriel Campos on 8/3/23.
//

import Foundation
import Combine

struct StrapiError: Decodable {
    let message: String
    
}

struct NetworkStrapiError: Error,  LocalizedError {
    let networkError: NetworkProvider.NetworkingError
    let strapiError: StrapiError
    
    var errorDescription: String? {
        strapiError.message
    }
}

class NetworkProvider {
    static let BearerToken = "dfdea37a44142d2e50cca7bbe80a959a5b4724a5581942cb5c43515eb8a556367306c7ae748545ec55dc59a9f49a701b9f9a54333cf6f43471684b7d7e4ade57552290a18e7e666bf6925f9030cab50ea1e15fb6f7763e79719941e0826b8b6359734d5a967c80595b13bf45c4113a62708fe05d895a0fa224d9d896a12ba781"
    
    enum Constants {
        static let baseURL = URL(string: "http://localhost:1337/api")!
    }
    
    enum NetworkingError: Error {
        case badURLResponse(url: String)
        case unknown
        /// Encoding issue when trying to send data.
        case encodingError(String?)
        /// No data recieved from the server.
        case noData
        /// The server response was invalid (unexpected format).
        case invalidResponse
        /// The request was rejected: 400-499
        case badRequest(String?)
        /// Encountered a server error.
        case serverError(String?)
        /// There was an error parsing the data.
        case parseError(String?)
        
        case signupError
        
        var errorDescription: String? {
            switch self {
            case .badURLResponse(url: let url): return "Bad response from URL \(url)"
            case .unknown: return "Unknown error ocurred"
            case .encodingError(_):
                return nil
            case .noData:
                return nil
            case .invalidResponse:
                return nil
            case .badRequest(_):
                return nil
            case .serverError(_):
                return nil
            case .parseError(_):
                return nil
            case .signupError:
                return "El email o nombre de usuario ya existe en el sistema"
            }
        }
    }
    
    
    func request(for request: URLRequest) -> AnyPublisher<Data, Error> {
        return URLSession.shared.dataTaskPublisher(for: request)
            .subscribe(on: DispatchQueue.global(qos: .default))
            .tryMap({ try self.handleURLResponse(output: $0, request: request)})
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func request<Value: Decodable>(
        for request: URLRequest,
        decoder: JSONDecoder = JSONDecoder()
    ) -> AnyPublisher<Value, Error> {
        self.request(for: request)
            .decode(type: Value.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    
    func handleURLResponse(
        output: URLSession.DataTaskPublisher.Output,
        request: URLRequest
    ) throws -> Data {
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300 else {
            print(output.response)
            throw NetworkingError.badURLResponse(url: request.url?.absoluteString ?? "")
        }
        
        if response.statusCode == 400 {
            throw NetworkingError.signupError
        }
        
        return output.data
    }
    
    
    
    func handleCompletion(completion: Subscribers.Completion<Error>) {
        switch completion {
        case .finished:
            break
        case .failure(let failure):
            print(failure.localizedDescription)
        }
    }
}

extension URLRequest {
    static var baseRequest: URLRequest {
        var request = URLRequest(url: NetworkProvider.Constants.baseURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func add(path: String) -> URLRequest {
        var request = self
        
        guard var url = request.url else { return self }
        
        url.appendPathComponent(path)
        request.url = url
        return request
    }
    
    func addParameters(value: String, name: String) -> URLRequest {
        var request = self
        guard let url = url else { return self }
        
        var urlParameters = URLComponents(url: url, resolvingAgainstBaseURL: false)
        var items = urlParameters?.queryItems ?? []
        
        items.append(
            URLQueryItem(name: name, value: value)
        )
        
        urlParameters?.queryItems = items
        
        request.url = urlParameters?.url
        
        return request
    }
    
    
    
}
