//
//  conveniences.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-24.
//

import Foundation

internal enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

extension Letterboxd {
    static let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // adjust this format to match your date string format
            df.locale = Locale(identifier: "en_US_POSIX")
            return df
        }()
    
    static func tryCatchPrintError(_ tryOp:() throws -> Void) {
        do {
           try tryOp()
        } catch let error {
            print(error)
        }
    }
}




// Order [String:String] and convert to url-encoded string
extension Dictionary where Key == String, Value == String {
    func urlEncodedString() -> String {
        return self.sorted(by: { $0.0 < $1.0 })
            .map { "\($0.key.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")=\($0.value.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")" }
            .joined(separator: "&")
    }
}


// Extension of DateFormatter for convenience initializer
extension DateFormatter {
    convenience init(format:String) {
        self.init()
        self.dateFormat = format
    }
}

//TODO: remove for production

extension Data {
    var prettyPrintedJSONString: String? {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
              let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted]),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            return nil
        }
        return jsonString
    }
}
