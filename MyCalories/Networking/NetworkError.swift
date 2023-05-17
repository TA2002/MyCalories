//
//  NetworkError.swift
//  MyCalories
//
//  Created by Tarlan Askaruly on 17.05.2023.
//

import Foundation

enum NetworkError: LocalizedError {
    case invalidUrlError
    case decodingError
    case serverError(String)
    case unknownError
    case noDataError
    
    var errorDescription: String? {
        switch self {
        case .invalidUrlError:
            return "Invalid URL"
        case .decodingError:
            return "Failed to decode a response"
        case .serverError(let error):
            return error
        case .unknownError:
            return "Something went wrong"
        case .noDataError:
            return "There is no data in network response"
        }
    }
}
