//
//  WebService.swift
//  News
//
//  Created by Cihan on 22.01.2024.
//

import Foundation

class WebService {
    
    //escaping closures swift
    
    func DownloadTheNews(url: URL, completion: @escaping ([News]?)-> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error  = error{
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
                let newsSeries = try? JSONDecoder().decode([News].self, from: data)
                
                if let newsSeries = newsSeries {
                    completion(newsSeries)
                }
            }
        }.resume()
    }
}
