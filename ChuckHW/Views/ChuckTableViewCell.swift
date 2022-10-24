//
//  ChuckTableViewCell.swift
//  ChuckHW
//
//  Created by Guy Cohen on 27/06/2022.
//

import UIKit

class ChuckTableViewCell: UITableViewCell {

    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    
    var jokeInCell: Joke? = nil {
        didSet {
            jokeLabel.text = jokeInCell?.value ?? ""
            rankLabel.text = String(jokeInCell?.rank ?? 0)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
