//
//  roommateCell.swift
//  newEssayProject
//
//  Created by Elıf on 23.06.2022.
//

import UIKit

class roommateCell: UITableViewCell {


    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var picView: UIImageView!
    @IBOutlet weak var roomLabel: UILabel!
    @IBOutlet weak var bathLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var smokeLabel: UILabel!
    @IBOutlet weak var preferPetLabel: UILabel!
    @IBOutlet weak var havePetLabel: UILabel!
    @IBOutlet weak var roomPrice: UILabel!
    @IBOutlet weak var name: UILabel!
    
    func configure() {
            
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        cardView.layer.shadowOpacity = 1.0
        cardView.layer.masksToBounds = false
        cardView.layer.cornerRadius = 10
        
        picView.layer.shadowColor = UIColor.gray.cgColor
        picView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        picView.layer.shadowOpacity = 1.0
        picView.layer.masksToBounds = false
        picView.layer.cornerRadius = 30
            
        }

    
}

