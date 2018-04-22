//
//  NetworkRequests.swift
//  WillowTreeNameGame
//
//  Created by Christopher Myers on 4/22/18.
//  Copyright © 2018 Dragoman Developers. All rights reserved.
//

import Foundation

enum NetworkResponse {
    case success(Data)
    case failure(Error)
}

class NetworkRequests {
    
    typealias JSONDictionary = [String : AnyObject]
    typealias JSONArray = [JSONDictionary]
    
    func loadNamesFromNetwork() {
        if let url = URL(string: AppConstants.namesURL) {
            let task = URLSession.shared.dataTask(with: url) {
                (data, response, error) in
                if error != nil {
                    // return failure(error) enum
                }
                if let namesDict = self.parseJSON(from: data) {

                    DispatchQueue.main.async {
                        print("Names Data as JSONDict")
                        print(namesDict)
                    }
                }
            }
            task.resume()
        } else {
            print("Not a valid url: \(AppConstants.namesURL)")
        }
    }
    
    private func parseJSON(from data : Data?) -> JSONArray? {
        var namesDict : JSONArray? = nil
        
        if let namesData = data {
            do {
                if let jsonDict = try JSONSerialization.jsonObject(with: namesData, options: []) as? JSONArray {
                    namesDict = jsonDict
                } else {
                    print("I could not parse JSON")
                }
            } catch {
                print(error)
            }
        }
        return namesDict
    }
}