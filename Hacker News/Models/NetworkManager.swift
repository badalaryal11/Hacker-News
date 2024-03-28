//
//  NetworkManager.swift
//  Hacker News
//
//  Created by Badal  Aryal on 09/02/2024.
//

import Foundation


class NetworkManager: ObservableObject  {
    
   @Published var posts = [Post]()
    
    func fetchData(){
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page"){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil{
                    let decoder = JSONDecoder()
                    // decode data that we got from networking session
                    
                    if let safeData = data { // optionally bind
                        do{
                           let results = try decoder.decode(Results.self, from: safeData)
                            DispatchQueue.main.async {
                                self.posts = results.hits
                            }
                            
                        } catch{
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
        
    }
}
