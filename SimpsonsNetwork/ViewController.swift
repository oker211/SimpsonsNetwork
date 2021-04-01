//
//  ViewController.swift
//  SimpsonsNetwork
//
//  Created by Филипп Слабодецкий on 01.04.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var quotoLabel: UILabel!
    @IBOutlet weak var characterLabel: UILabel!
    @IBOutlet weak var image: UIImageView!
    
    let urlApi = "https://simpsons-quotes-api.herokuapp.com/quotes"
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchRequest()
        
    }
    
    @IBAction func nextButton() {
        fetchRequest()
    }
    
    private func fetchRequest() {
        NetworkManager.shared.fetchData(from: urlApi) { (dataSimpsons) in
            self.characterLabel.text = dataSimpsons.first?.character
            self.quotoLabel.text = dataSimpsons.first?.quote
            
            guard let imageData = ImageManager.shared.fetchImage(from: dataSimpsons.first?.image) else {return}
            self.image.image = UIImage(data: imageData)
        }
    }
}
