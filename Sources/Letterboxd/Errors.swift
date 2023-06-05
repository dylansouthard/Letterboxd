//
//  Errors.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-06-05.
//

import Foundation


public enum LetterboxdError: Error {
    case noData
    case badRequest(message: String?)
    case unauthorized(message: String?)
    case forbidden(message: String?)
    case notFound(message: String?)
    case tooManyRequests(message: String?)
    case serverError(message: String?)
    case genericError(message:String?)
    case noToken
    
    var localizedDescription: String {
        switch self {
        case .noData:
            return "Success, but no data returned."
        case .badRequest(let message):
            return "Bad request. \(message ?? "")"
        case .unauthorized(let message):
            return "Unauthorized access. \(message ?? "")"
        case .forbidden(let message):
            return "Forbidden. \(message ?? "")"
        case .notFound(let message):
            return "Resource not found. \(message ?? "")"
        case .tooManyRequests(let message):
            return "Too many requests. \(message ?? "")"
        case .serverError(let message):
            return "Server error. \(message ?? "")"
        case .genericError(let message):
            return "Error. \(message ?? "")"
        case .noToken:
            return "There is no token available or the token refresh failed."
        }
    }
}


extension Data {
    var errorMessage:String? {
        if let json = try? JSONSerialization.jsonObject(with: self) as? [String: Any], let message = json["message"] as? String {
            return message
        }
        return nil
    }
}
