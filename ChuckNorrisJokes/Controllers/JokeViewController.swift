//
//  JokeViewController.swift
//  ChuckNorrisJokes
//
//  Created by Vanina Fileva on 25.10.20.
//

import UIKit

class JokeViewController: UIViewController {
    
    @IBOutlet weak var textLabel: UILabel!
    
    var category: String?
    var joke: Joke? {
        didSet {
            DispatchQueue.main.async {
                self.textLabel.text = self.joke?.text
            }
        }
    }
    private let dataFetcher: DataFetching
    
    private var dataPersistor: DataPersisting
    
    required init?(coder: NSCoder) {
        self.dataFetcher = NetworkManager.shared
        self.dataPersistor = StorageManager.shared
        super.init(coder: coder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataFetcher.getRandomJoke(in: category, closure: {joke in
            self.joke = joke
        })
    }
    
    @IBAction func tapped(_ save: Any) {
        let alert = UIAlertController(title: nil, message: "Save joke as:", preferredStyle: .alert)
        var jokeTextField: UITextField?
        alert.addTextField(configurationHandler: { textField in
            textField.text = self.joke?.text
            jokeTextField = textField
        })
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            if let text = jokeTextField?.text {
                self.dataPersistor.jokes.append(text)
            }
        })
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

}


