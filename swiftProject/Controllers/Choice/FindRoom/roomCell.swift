//
//  roomCell.swift
//  newEssayProject
//
//  Created by Elıf on 10.06.2022.
//

import UIKit

class roomCell: UITableViewCell {
    
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var petLabel: UILabel!
    @IBOutlet weak var smokeLabel: UILabel!
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure() {
        
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 10
        
        
        pictureView.layer.shadowColor = UIColor.gray.cgColor
        pictureView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        pictureView.layer.shadowOpacity = 1.0
        pictureView.layer.masksToBounds = false
        pictureView.layer.cornerRadius = 30
        
    }
}
