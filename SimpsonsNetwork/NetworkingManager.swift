//
//  NetworkingManager.swift
//  SimpsonsNetwork
//
//  Created by Филипп Слабодецкий on 01.04.2021.
//

import Foundation

 class NetworkManager {

    static let shared = NetworkManager()
    
    private init(){}

    func fetchData(from urlString: String, with complition: @escaping ([Simpsons]) -> Void) {
        
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let data = data else {return}
            
            do{
                let dataSimpsons = try JSONDecoder().decode([Simpsons].self, from: data)
                DispatchQueue.main.async {
                    complition(dataSimpsons)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }.resume()
    }
}

class ImageManager {
    
    static var shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }
        return try? Data(contentsOf: imageURL)
    }
    
}
