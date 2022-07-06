//
//  FindRoomsViewController.swift
//  newEssayProject
//
//  Created by Elıf on 9.06.2022.
//

import UIKit
import Firebase

class FindRoomsViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imagePicker: UIImageView!
    
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderSegment: UISegmentedControl!
    
    @IBOutlet weak var petLabel: UILabel!
    @IBOutlet weak var petSegment: UISegmentedControl!
    
    @IBOutlet weak var smokeLabel: UILabel!
    @IBOutlet weak var smokeSegment: UISegmentedControl!
    
    @IBOutlet weak var budgetLabel: UILabel!
    @IBOutlet weak var budgetSlider: UISlider!
    
    @IBOutlet weak var noteText: UITextField!
    
    @IBOutlet weak var citiesText: UITextField!
    let cities = ["Adana", "Adıyaman", "Afyon", "Ağrı", "Amasya", "Ankara", "Antalya", "Artvin", "Aydın", "Balıkesir", "Bilecik", "Bingöl", "Bitlis", "Bolu", "Burdur", "Bursa", "Çanakkale", "Çankırı", "Çorum", "Denizli", "Diyarbakır", "Edirne", "Elazığ", "Erzincan", "Erzurum", "Eskişehir", "Gaziantep", "Giresun", "Gümüşhane", "Hakkari", "Hatay", "Isparta", "İçel (Mersin)", "İstanbul", "İzmir", "Kars", "Kastamonu", "Kayseri", "Kırklareli", "Kırşehir", "Kocaeli", "Konya", "Kütahya", "Malatya", "Manisa", "Kahramanmaraş", "Mardin", "Muğla", "Muş", "Nevşehir", "Niğde", "Ordu", "Rize", "Sakarya", "Samsun", "Siirt", "Sinop", "Sivas", "Tekirdağ", "Tokat", "Trabzon", "Tunceli", "Şanlıurfa", "Uşak", "Van", "Yozgat", "Zonguldak", "Aksaray", "Bayburt", "Karaman", "Kırıkkale", "Batman", "Şırnak", "Bartın", "Ardahan", "Iğdır", "Yalova", "Karabük", "Kilis", "Osmaniye", "Düzce"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            view.addGestureRecognizer(tap)
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "findroom")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        UINavigationBar.appearance().backgroundColor = UIColor(white: 1, alpha: 0.5)
        
        picker.delegate = self
        picker.dataSource = self
                
        budgetSlider.value = 0
        budgetLabel.text = String(budgetSlider.value)
        
        imagePicker.layer.shadowColor = UIColor.gray.cgColor
        imagePicker.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        imagePicker.layer.shadowOpacity = 1.0
        imagePicker.layer.masksToBounds = false
        imagePicker.layer.cornerRadius = 30
        
        imagePicker.layer.masksToBounds = true
        imagePicker?.isUserInteractionEnabled = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(choseImage))
        imagePicker.addGestureRecognizer(gestureRecognizer)

        // Do any additional setup after loading the view.
    }
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
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

    
    @IBAction func uploadButtonClicked(_ sender: Any) {

        
        let storage = Storage.storage()
        let storageReference = storage.reference()
        let usersFindRooms = storageReference.child("usersFindRooms")
        
        if let data = imagePicker.image?.jpegData(compressionQuality: 0.5) {
            let uuid = UUID().uuidString
            let imageReference = usersFindRooms.child("\(uuid).png")
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
                            
                            let firestorePost = ["imageUrl" : imageUrl!, "postedBy" : Auth.auth().currentUser!.email!, "genderLabel" : self.genderLabel.text!, "smokeLabel" : self.smokeLabel.text!, "petLabel" : self.petLabel.text!, "budgetLabel" : self.budgetLabel.text!, "noteText" : self.noteText.text!, "citiesText" : self.citiesText.text!,
                                                 "nameText" : self.nameText.text!, "date" : FieldValue.serverTimestamp() ] as [String : Any]
                            firestoreReference = firestoreDatabase.collection("usersFindRooms").addDocument(data: firestorePost, completion: { (error) in
                                if error != nil {
                                    self.makeAlert(titleInput: "Error!", messageInput: error?.localizedDescription ?? "Error!")

                                }else {
                                    self.performSegue(withIdentifier: "toFindRoomCell", sender: nil)
                                }
                            })
                            
                        }
                        
                    }
                    
                }
            }
            
        }
        
    }

    //SEGMENTS
    @IBAction func didGenderSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            genderLabel.text = "female"
        }else {
            genderLabel.text = "male"
        }
    }
    
    @IBAction func didPetSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            petLabel.text = "Yes"
        }else {
            petLabel.text = "No"
        }
    }
    
    @IBAction func didSmokeSegment(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            smokeLabel.text = "Yes"
        }else {
            smokeLabel.text = "No"
        }
    }
    
    @IBAction func didSliderBudget(_ sender: Any) {
        
        budgetLabel.text = String(format: "%.0f" , budgetSlider.value)
                
    }
}

//PICKET CITIES
extension FindRoomsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cities.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        citiesText.text = cities[row]
        citiesText.resignFirstResponder()
        
    }
    
    
}
extension FindRoomsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return cities[row]
    }
}
