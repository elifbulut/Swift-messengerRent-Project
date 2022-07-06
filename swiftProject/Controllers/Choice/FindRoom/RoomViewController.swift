//
//  RoomViewController.swift
//  newEssayProject
//
//  Created by Elıf on 10.06.2022.
//
//ROOM FEED VIEW CONTROLLER

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class RoomViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cardTableView: UITableView!
    
    var userNameArray = [String]()
    var userImageArray = [String]()
    var userEmailArray = [String]()
    var userCitiesArray = [String]()
    var userGenderArray = [String]()
    var userSmokeArray = [String]()
    var userPetArray = [String]()
    var userBudgetArray = [String]()
    var userNoteArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "sa")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        UINavigationBar.appearance().backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        cardTableView.delegate = self
        cardTableView.dataSource = self
        
        getDataFromFireStore()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func toChatButton(_ sender: UIButton) {
        performSegue(withIdentifier: "toChat", sender: nil)
    }
    
    func getDataFromFireStore() {
        
        
        
        let fireStoreDatabase = Firestore.firestore()
                
        fireStoreDatabase.collection("usersFindRooms").order(by: "date", descending: true).addSnapshotListener { (snapshot, error)
            in
                if error != nil {
                    print(error?.localizedDescription)
                }else {
                    if snapshot?.isEmpty != true && snapshot != nil {
                        
                        self.userImageArray.removeAll(keepingCapacity: false)
                        self.userNoteArray.removeAll(keepingCapacity: false)
                        self.userPetArray.removeAll(keepingCapacity: false)
                        self.userSmokeArray.removeAll(keepingCapacity: false)
                        self.userBudgetArray.removeAll(keepingCapacity: false)
                        self.userGenderArray.removeAll(keepingCapacity: false)
                        self.userCitiesArray.removeAll(keepingCapacity: false)
                        self.userEmailArray.removeAll(keepingCapacity: false)
                        self.userNameArray.removeAll(keepingCapacity: false)
                        for document in snapshot!.documents {
                            let documentID = document.documentID
                            
                            if let postedBy = document.get("postedBy") as? String {
                                self.userEmailArray.append(postedBy)
                            }
                            if let imageUrl = document.get("imageUrl") as? String {
                                self.userImageArray.append(imageUrl)
                            }
                           
                            if let smokeLabel = document.get("smokeLabel") as? String {
                                self.userSmokeArray.append(smokeLabel)
                            }
                            if let budgetLabel = document.get("budgetLabel") as? String {
                                self.userBudgetArray.append(budgetLabel)
                            }
                            if let petLabel = document.get("petLabel") as? String {
                                self.userPetArray.append(petLabel)
                            }
                            if let noteText = document.get("noteText") as? String {
                                self.userNoteArray.append(noteText)
                            }
                            if let genderLabel = document.get("genderLabel") as? String {
                                self.userGenderArray.append(genderLabel)
                            }
                            if let citiesText = document.get("citiesText") as? String {
                                self.userCitiesArray.append(citiesText)
                            }
                            if let nameText = document.get("nameText") as? String {
                                self.userNameArray.append(nameText)
                            }
                        }
                        self.cardTableView.reloadData()
                    }
                }
            }
            
            
            
        }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? roomCell
        cell?.pictureView.image = UIImage(named: "logo")
        cell?.genderLabel.text = userGenderArray[indexPath.row]
        cell?.petLabel.text = userPetArray[indexPath.row]
        cell?.smokeLabel.text = userSmokeArray[indexPath.row]
        cell?.cityLabel.text = userCitiesArray[indexPath.row]
        cell?.budgetLabel.text = userBudgetArray[indexPath.row]
        cell?.noteLabel.text = userNoteArray[indexPath.row]
        cell?.nameLabel.text = userNameArray[indexPath.row]
        cell?.pictureView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
        cell?.configure()
        return cell!
    }
    
    

}
