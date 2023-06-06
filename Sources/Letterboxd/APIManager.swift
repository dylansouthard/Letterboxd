
//  LetterboxdAPIManager.swift
//  LetterboxdTest
//
//  Created by Dylan Southard on 2023-05-24.
//

import Foundation
import CommonCrypto

extension Letterboxd {
    
    //MARK: - =============== CONSTRUCTORS ===============
    
    
    //MARK: - === REQUEST ===
    
    // These functions are used to construct the HTML request
    static func constructJSONRequest(_ urlString:String, method:HTTPMethod = .get, queryParams:[URLQueryItem] = [], bodyParams:[String:Any] = [:])->URLRequest? {
        
        //SET PARAMS
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = constructQueryItems(queryParams: queryParams)

        // Get the full URL after the query parameters have been added
        guard let fullUrl = urlComponents?.url?.absoluteString else {return nil}

        // Serialize bodyParams to JSON
        guard let bodyData = try? JSONSerialization.data(withJSONObject: bodyParams, options: []) else { return nil }
        let body = String(data: bodyData, encoding: .utf8)

        // Create the message and generate the signature
        let message = "\(method.rawValue)\u{0000}\(fullUrl)\u{0000}\(body ?? "")"
        guard let signature = createSignature(message: message) else {return nil}
        urlComponents?.queryItems?.append(URLQueryItem(name: "signature", value: signature))

        // Get the final URL, now including the signature
        guard let urlWithSignature = urlComponents?.url else {return nil}

        // CONSTRUCT REQUEST
        var request = URLRequest(url: urlWithSignature)
        request.httpMethod = method.rawValue
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = bodyData

        return request
    }
    
    // ----------------------------------------------------------------------------------------------------------------------------------------
    
    static func constructRequest(_ urlString:String, method:HTTPMethod = .get, queryParams:[URLQueryItem] = [], bodyParams:[String:String] = [:])->URLRequest? {

        //SET PARAMS
        var urlComponents = URLComponents(string: urlString)
           urlComponents?.queryItems = constructQueryItems(queryParams: queryParams)


        let body = bodyParams.urlEncodedString()

        guard let fullUrl = urlComponents?.url?.absoluteString else {return nil}

        //CREATE SIGNED URL
        let message = "\(method.rawValue)\u{0000}\(fullUrl)\u{0000}\(body)"
        guard let signature = createSignature(message: message) else {return nil}
        urlComponents?.queryItems?.append(URLQueryItem(name: "signature", value: signature))

        // CONSTRUCT REQUEST
        guard let url = urlComponents?.url else {return nil}
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = body.data(using: .utf8)

        return request
    }

    
    
    //MARK: - === QUERY STRING ===
    
    // ----------------------------------------------------------------------------------------------------------------------------------------
    
    private static func constructQueryItems(queryParams:[URLQueryItem])-> [URLQueryItem] {
        
        // Create nonce and timestamp
        let nonce = UUID().uuidString
        let timestamp = String(Int(Date().timeIntervalSince1970))

        //Add to query items
        var queryItems: [URLQueryItem] = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "nonce", value: nonce),
            URLQueryItem(name: "timestamp", value: timestamp)
        ]
        
        queryItems.append(contentsOf: queryParams)
        return queryItems
    }
    
    
    
    //MARK: - === SIGNATURE ===
    
    // ----------------------------------------------------------------------------------------------------------------------------------------
    
    // This function generates a HMAC-SHA256 signature for the message string.
    static func createSignature(message: String) -> String? {
        guard let secret = apiSecret else {return nil}
        // Convert the API secret and message to data
        let keyData = secret.data(using: .utf8)!
        let messageData = message.data(using: .utf8)!

        // Initialize an array to store the digest.
        var digest = [UInt8](repeating: 0, count: Int(CC_SHA256_DIGEST_LENGTH))
        
        // Get a pointer to the key data and message data
        let keyBytes = keyData.withUnsafeBytes { $0.baseAddress!.assumingMemoryBound(to: UInt8.self) }
        let dataBytes = messageData.withUnsafeBytes { $0.baseAddress!.assumingMemoryBound(to: UInt8.self) }

        // Perform HMAC-SHA256 hashing
        CCHmac(CCHmacAlgorithm(kCCHmacAlgSHA256), keyBytes, keyData.count, dataBytes, messageData.count, &digest)

        // Convert the digest to data
        let hmacData = Data(digest)
        
        // Convert the data to a hexadecimal string
        let hmacHex = hmacData.map { String(format: "%02hhx", $0) }.joined()

        // URL encode the signature and return it
        return hmacHex.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
    

    
    
    //MARK: - =============== EXECUTION ===============
    
    
    //MARK: - === REQUEST HANDLERS ===
    
    // ----------------------------------------------------------------------------------------------------------------------------------------
    
    // Functions to send a request to a given Letterboxd Query
    static func sendRequest(_ query:LBQuery, requiresAuth:Bool, isTokenRequest:Bool = false, handler:@escaping (Result<(Data?, URLResponse), Error>)->Void) {
        
        // Construct the request. If it fails, call the handler with an error.
        guard let request = constructRequest(query.urlString, method: query.method, queryParams: query.queryParams, bodyParams: query.bodyParams) else {
            handler(.failure(LetterboxdError.genericError(message:"Error constructing request")))
            return
        }
        // If the request construction is successful, execute the request.
        executeRequest(request, requiresAuth:requiresAuth, isTokenRequest:isTokenRequest, handler: handler)
    }

    //same as above, but for requests that require a JSON body
    static func sendJSONRequest(_ query:LBJSONQuery, requiresAuth:Bool, handler:@escaping (Result<(Data?, URLResponse), Error>)->Void) {
        
        guard let request = constructJSONRequest(query.urlString, method: query.method, queryParams: query.queryParams, bodyParams: query.bodyParams) else {
            handler(.failure(LetterboxdError.genericError(message:"Error constructing request")))
            return
        }
        
        executeRequest(request, requiresAuth:requiresAuth, handler: handler)
    }

    
    
    // ----------------------------------------------------------------------------------------------------------------------------------------

    
    // Function to execute a URLRequest
    static func executeRequest(_ request: URLRequest, requiresAuth: Bool = true, isTokenRequest:Bool = false, handler: @escaping (Result<(Data?, URLResponse), Error>) -> Void) {
        // Helper function to execute a URLSession dataTask
        func taskExecution(_ req:URLRequest) {
            let task = URLSession.shared.dataTask(with: req) { (data, response, error) in
                
                // Print the response and error for debugging
//                print(response)
//                if let e = error {
//                    print(e)
//                }
                
                DispatchQueue.main.async {
                            if let error = error {
                               
                                handler(.failure(error))
                            } else if let httpResponse = response as? HTTPURLResponse {
                                switch httpResponse.statusCode {
                                case 200..<300:
                                    handler(.success((data, httpResponse)))
                                case 400:
                                    handler(.failure(LetterboxdError.badRequest(message: data?.errorMessage)))
                                case 401:
                                    handler(.failure(LetterboxdError.unauthorized(message: data?.errorMessage)))
                                case 403:
                                    handler(.failure(LetterboxdError.forbidden(message: data?.errorMessage)))
                                case 404:
                                    handler(.failure(LetterboxdError.notFound(message: data?.errorMessage)))
                                case 429:
                                    handler(.failure(LetterboxdError.tooManyRequests(message: data?.errorMessage)))
                                default:
                                    handler(.failure(LetterboxdError.serverError(message: data?.errorMessage)))
                                }

                            } else {
                                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "Unknown error"])
                                handler(.failure(error))
                            }
                        }
                    }
                    task.resume()
        }
        
        
        if isTokenRequest {
            taskExecution(request)
            return
        }
    
        //AUTHORIZATION
    
        
        // If the request requires authentication, check the token
       
            tokenManager?.checkToken() { result in
              
                switch result {
                case .success(let token):
//                    print(request.url)
                    // If the token check is successful, add the token to the request and execute the task
                    var req = request
                    req.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
                    taskExecution(req)
                    
                case .failure:
                    if requiresAuth {
                        // If the token check fails, pass the error to the handler
                        handler(.failure(LetterboxdError.noToken))
                    } else {
                        taskExecution(request)
                    }
                    
                }
            }
        
    }
}
