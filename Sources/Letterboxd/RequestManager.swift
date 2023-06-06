//
//  LetterboxdRequests.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-24.
//

import Foundation


extension Letterboxd {
 
    //MARK: - =============== QUERY STRUCTS ===============
    
    struct LBQuery {
        var urlString:String
        var method:HTTPMethod
        var queryParams:[URLQueryItem]
        var bodyParams:[String:String]
    
        init (_ urlString:String, method:HTTPMethod = .get, queryParams:[URLQueryItem] = [], bodyParams:[String:String] = [:]) {
            self.urlString = urlString
            self.queryParams = queryParams
            self.bodyParams = bodyParams
            self.method = method
            
        }
    }
    
    struct LBJSONQuery {
        var urlString:String
        var method:HTTPMethod = .get
        var queryParams:[URLQueryItem] = []
        var bodyParams:[String:Any] = [:]
        
        init (_ urlString:String, method:HTTPMethod = .get, queryParams:[URLQueryItem] = [], bodyParams:[String:Any] = [:]) {
            self.urlString = urlString
            self.queryParams = queryParams
            self.bodyParams = bodyParams
            self.method = method
            
        }
    }
    
    
    //MARK: - =============== GENERIC FETCH HANDLER ===============
    internal static func fetchData<T: Decodable>(_ query: LBQuery, handler: @escaping(Result<T, Error>) -> Void, requiresAuth:Bool = false) {
        sendRequest(query, requiresAuth:requiresAuth, handler:{result in
            switch result {
            case .success(let (d, response)):
                if let httpResponse = response as? HTTPURLResponse, let data = d, httpResponse.statusCode == 200 {
                    do {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        handler(.success(decodedData))
                    } catch {
                        handler(.failure(error))
                    }
                } else {
//                    if let jsonString = d?.prettyPrintedJSONString {
//                        print(jsonString)
//                    }
                    let error = NSError(domain: "", code: (response as? HTTPURLResponse)?.statusCode ?? -1, userInfo: [NSLocalizedDescriptionKey : "Unexpected server response"])
                    handler(.failure(error))
                }
            case .failure(let error):
                handler(.failure(error))
            }
        })
    }
   

}


