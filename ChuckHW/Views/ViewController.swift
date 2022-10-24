//
//  ViewController.swift
//  ChuckHW
//
//  Created by Yair Kerem on 27/06/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var chuckTableView: UITableView!
    
    @IBOutlet weak var mainImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    var service = ChuckNorrisService.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chuckTableView.dataSource = self
        
        Task {
            if let image = await service.getChuckImage(chuckNorrisImage: ChuckNorrisService.defaultImage){
                self.mainImageView.image = image
            }
            await service.getChuckJokes()
            self.chuckTableView.reloadData()
            titleLabel.text = service.chuckNorrisTitle()
        }
        
        titleLabel.text = service.chuckNorrisTitle()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        self.mainImageView.isUserInteractionEnabled = true
        self.mainImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let _ = tapGestureRecognizer.view as! UIImageView
        let randomImageNumber = Int.random(in: 0..<10)
        let newImage = service.replaceHeroImage(listIndex: randomImageNumber)
        Task {
            if let image = await service.getChuckImage(chuckNorrisImage: newImage) {
                    self.mainImageView.image = image
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChuckNorrisService.shared.chuckJokes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChuckTableViewCell") as! ChuckTableViewCell
        let joke = ChuckNorrisService.shared.chuckJokes[indexPath.row]
        cell.jokeInCell = joke
        return cell
    }
}


extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let destination = segue.destination as? DetailsViewController,
           let senderCell = sender as? ChuckTableViewCell {
            
            destination.joke = senderCell.jokeInCell
            destination.delegate = self
        }
    }
}

extension ViewController: DetailsViewControllerDelegate {
    func jokesUpdated() {
        chuckTableView.reloadData()
    }
}




















