//
//  FindRoommateViewController.swift
//  newEssayProject
//
//  Created by Elıf on 11.06.2022.
//

import UIKit
import Firebase

class FindRoommateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var imagePicker: UIImageView!
    
    @IBOutlet weak var roomLabel: UILabel!
    
    @IBOutlet weak var bathLabel: UILabel!
    
    @IBOutlet weak var hostLabel: UILabel!
    
    @IBOutlet weak var genderLabel: UILabel!
    
    @IBOutlet weak var smokeLabel: UILabel!
    
    @IBOutlet weak var preferPetLabel: UILabel!
    
    @IBOutlet weak var havePetLabel: UILabel!
    
    @IBOutlet weak var roomPrice: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

        self.navigationController?.navigationBar.layer.shadowColor = UIColor.white.cgColor
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 4.0
        self.navigationController?.navigationBar.layer.shadowOpacity = 1.0
        self.navigationController?.navigationBar.layer.masksToBounds = false

            view.addGestureRecognizer(tap)

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "findroom")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        // Do any additional setup after loading the view.

         
        imagePicker?.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choseImage))
        imagePicker.addGestureRecognizer(gestureRecognizer)
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    //SEGMENTS
    @IBAction func roomSegment(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            roomLabel.text = "1 + 0"
        }else if (sender.selectedSegmentIndex == 1) {
            roomLabel.text = "1 + 1"
        }else if (sender.selectedSegmentIndex == 2) {
            roomLabel.text = "2 + 1"
        }else if (sender.selectedSegmentIndex == 3) {
            roomLabel.text = "3 + 1"
        }else {
            roomLabel.text = "4 + 1"
        }
    }
    
    @IBAction func bathSegment(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            bathLabel.text = "1"
        }else if (sender.selectedSegmentIndex == 1) {
            bathLabel.text = "2"
        }else if (sender.selectedSegmentIndex == 2) {
            bathLabel.text = "3"
        
        }
    }
    
    @IBAction func genderHostSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            hostLabel.text = "female"
        }else {
            hostLabel.text = "male"
        }
    }
    
    @IBAction func preferredGender(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            genderLabel.text = "female"
        }else {
            genderLabel.text = "male"
        }
    }
    
    @IBAction func smokeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            smokeLabel.text = "YES"
        }else {
            smokeLabel.text = "NO"
        }
    }
    
    
    @IBAction func preferPets(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            preferPetLabel.text = "YES"
        }else {
            preferPetLabel.text = "NO"
        }
    }
    @IBAction func havePets(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            havePetLabel.text = "YES"
        }else {
            havePetLabel.text = "NO"
        }
    }
    //Resim sectigimiz fonksiyonumuz
    @objc func choseImage(){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePicker.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func uploadButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let usersRoommateFolder = storageReference.child("usersRoommate")
        
        if let data = imagePicker.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            
            let imageReference = usersRoommateFolder.child("\(uuid).png")
            imageReference.putData(data, metadata: nil){ (metadata, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error ! ", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    
                    imageReference.downloadURL { (url, error) in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            //DATABASE
                            
                            let  firestoreDatabase = Firestore.firestore()
                            
                            var firestoreReference : DocumentReference? = nil
                            let firestorePost = ["imageUrl" : imageUrl!,
                                                "postedBy" : Auth.auth().currentUser!.email!,
                                                "roomLabel" : self.roomLabel.text!,
                                                "bathLabel" : self.bathLabel.text!,
                                                "hostLabel" : self.hostLabel.text!,
                                                "genderLabel" : self.genderLabel.text!,
                                                "smokeLabel" : self.smokeLabel.text!,
                                                "preferPetLabel" : self.preferPetLabel.text!,
                                                "havePetLabel" : self.havePetLabel.text!,
                                                "roomPrice" : self.roomPrice.text!,
                                                "name":self.name.text!,
                                                "date" : FieldValue.serverTimestamp() ]
                                                            as [String : Any]
                            firestoreReference = firestoreDatabase.collection("usersRoommate").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")

                                }else {
                                    self.performSegue(withIdentifier: "roommateCell", sender: nil)
                                }
                            })
                            
                        }
                        
                    }
                    
                }
            }
            
        }
        
    }

    }
