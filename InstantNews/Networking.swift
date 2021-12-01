//
//  Networking.swift
//  InstantNews
//
//  Created by Developer on 30/11/21.
//

import Foundation

enum NewsError:Error {
    case NoDataAvailable
    case CanNotProcessData
}
let newsURL = "https://economictimes.indiatimes.com/rssfeedstopstories.cms"

struct Networking {
    
    static let sharedInstance = Networking()
    let session = URLSession.shared
    
 
    func getNews(completion: @escaping(_ data: Data?, _ error: Error)->()) {
        
        let url = URL(string: newsURL)!
        let dataTask = session.dataTask(with: url) {data, response , error in
            
            completion(data, error as! Error)
           
          

        }
        dataTask.resume()
    }
    
    
}
