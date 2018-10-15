//
//  NetworkService.swift
//  ForecastWeather
//
//  Created by Chirag on 13/10/18.
//  Copyright © 2018 Chirag. All rights reserved.
//

import Foundation
import Alamofire

protocol RequestProtocol {
    //Request protocol
    func callService<T : BaseModel>(method: MethodType, param: T?, path: URL, responseModel:T.Type, success:@escaping (_ result:T)->(), failure:@escaping failerHandler)
}

class Request: RequestProtocol {
    
    static let shared = Request()
    private var alamofireManager: Alamofire.SessionManager?
    
    private init() {}
    
    //MARK:- Request Delegagte methods
    func callService<T : BaseModel>(method: MethodType, param: T?, path: URL, responseModel:T.Type, success:@escaping (_ result:T)->(), failure:@escaping failerHandler) {
        var data:Data?
        
        do {
            //create request object
            var request = URLRequest(url: path)
            request.httpMethod = method.rawValue
            request.setValue("application-json", forHTTPHeaderField: "content-type")
            
            if let dataParam = param {
                data = try JSONEncoder().encode(dataParam)
            }
            
            request.httpBody = data
            Alamofire.request(request).responseData { (response) in
                guard response.result.isSuccess else {
                    failure(requestError.serviceError)
                    return
                }
                
                guard response.value != nil else {
                    failure(requestError.notValidResponse)
                    return
                }
                
                do {
                    //Json decoder
                    let result = try JSONDecoder().decode(responseModel.self, from: response.data!)
                    success(result)
                } catch let error as Error  {
                    print(error)
                    failure(requestError.notValidResponse)
                }
                
            }
            
        } catch  {
            failure(requestError.paramInvalid)
        }
    }
}
