//
//  roommateViewController.swift
//  newEssayProject
//
//  Created by Elıf on 23.06.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import SDWebImage


class roommateViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var cardRoommateView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let back = UIImageView(frame: UIScreen.main.bounds)
        back.image = UIImage(named: "new")
        back.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(back, at: 0)
        
      //  UINavigationBar.appearance().backgroundColor = UIColor(white: 1, alpha: 0.5)

        cardRoommateView.delegate = self
        cardRoommateView.dataSource = self
        
        getDataFromFireStore()

        // Do any additional setup after loading the view.
    }
    
    var userImageArray = [String]()
    var userEmailArray = [String]()
    var userRoomArray = [String]()
    var userBathArray = [String]()
    var userHostArray = [String]()
    var userGenderArray = [String]()
    var userSmokeArray = [String]()
    var userPreperPetArray = [String]()
    var userHavePetArray = [String]()
    var nameArray = [String]()
    var roomPriceArray = [String]()
        
    // Do any additional setup after loading the view.

    
    @IBAction func toChat2Button(_ sender: UIButton) {
        performSegue(withIdentifier: "to2", sender: nil)
    }
    
    
func getDataFromFireStore(){
    
    let fireStoreDatabase = Firestore.firestore()
    
    fireStoreDatabase.collection("usersRoommate").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
        if error != nil {
            print(error?.localizedDescription)
            
        }else {
            if snapshot?.isEmpty != true && snapshot != nil {
                
                self.userImageArray.removeAll(keepingCapacity: false)
                self.userEmailArray.removeAll(keepingCapacity: false)
                self.userRoomArray.removeAll(keepingCapacity: false)
                self.userBathArray.removeAll(keepingCapacity: false)
                self.userHostArray.removeAll(keepingCapacity: false)
                self.userGenderArray.removeAll(keepingCapacity: false)
                self.userSmokeArray.removeAll(keepingCapacity: false)
                self.userPreperPetArray.removeAll(keepingCapacity: false)
                self.userHavePetArray.removeAll(keepingCapacity: false)
                self.nameArray.removeAll(keepingCapacity: false)
                self.roomPriceArray.removeAll(keepingCapacity: false)


                for document in snapshot!.documents {
                    let documentID = document.documentID
                    
                    if let postedBy = document.get("postedBy") as? String {
                        self.userEmailArray.append(postedBy)
                    }
                    if let imageUrl = document.get("imageUrl") as? String {
                        self.userImageArray.append(imageUrl)
                    }
                    if let roomLabel = document.get("roomLabel") as? String {
                        self.userRoomArray.append(roomLabel)
                    }
                    if let bathLabel = document.get("bathLabel") as? String {
                        self.userBathArray.append(bathLabel)
                    }
                    if let hostLabel = document.get("hostLabel") as? String {
                        self.userHostArray.append(hostLabel)
                    }
                    if let genderLabel = document.get("genderLabel") as? String {
                        self.userGenderArray.append(genderLabel)
                    }
                    if let smokeLabel = document.get("smokeLabel") as? String {
                        self.userSmokeArray.append(smokeLabel)
                    }
                    if let preferPetLabel = document.get("preferPetLabel") as? String {
                        self.userPreperPetArray.append(preferPetLabel)
                    }
                    if let havePetLabel = document.get("havePetLabel") as? String {
                        self.userHavePetArray.append(havePetLabel)
                    }
                    if let name = document.get("name") as? String {
                        self.nameArray.append(name)
                    }
                    if let roomPrice = document.get("roomPrice") as? String {
                        self.roomPriceArray.append(roomPrice)
                    }
                }
                self.cardRoommateView.reloadData()
            }
        }
    }
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "roommateCell", for: indexPath) as! roommateCell

                cell.picView.image = UIImage(named: "select")
                cell.roomLabel.text = userRoomArray[indexPath.row]
                cell.bathLabel.text = userBathArray[indexPath.row]
                cell.genderLabel.text = userGenderArray[indexPath.row]
                cell.hostLabel.text = userHostArray[indexPath.row]
                cell.smokeLabel.text = userSmokeArray[indexPath.row]
                cell.preferPetLabel.text = userPreperPetArray[indexPath.row]
                cell.havePetLabel.text = userHavePetArray[indexPath.row]
                cell.name.text = nameArray[indexPath.row]
                cell.roomPrice.text = roomPriceArray[indexPath.row]
                cell.picView.sd_setImage(with: URL(string: self.userImageArray[indexPath.row]))
                cell.configure()
                return cell
            }
    
}
