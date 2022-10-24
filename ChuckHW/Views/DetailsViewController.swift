//
//  DetailsViewController.swift
//  ChuckHW
//
//  Created by Yair Kerem on 29/06/2022.
//

import UIKit

protocol DetailsViewControllerDelegate: AnyObject {
    func jokesUpdated()
}

class DetailsViewController: UIViewController {

    var joke: Joke? = nil
    var service = ChuckNorrisService.shared

    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var jokeRankLabel: UILabel!
    @IBOutlet weak var rankSlider: UISlider!
    
    weak var delegate: DetailsViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jokeLabel.text = joke?.value ?? ""
        rankSlider.value = Float(joke?.rank ?? 0)
        jokeRankLabel.text = String(Int(rankSlider.value))
    }
    
    @IBAction func rankingChanged(_ sender: UISlider) {
        jokeRankLabel.text = String(Int(sender.value))
    }
    
    @IBAction func saveTapped(_ sender: UIButton) {
        if var joke = joke {
            joke.rank = Int(rankSlider.value)
            service.update(joke: joke)
            delegate?.jokesUpdated()
        }
        
        self.dismiss(animated: true)
    }
    
}
