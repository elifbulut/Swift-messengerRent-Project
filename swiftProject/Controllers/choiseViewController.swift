//
//  choiseViewController.swift
//  newEssayProject
//
//  Created by Elıf on 9.06.2022.
//

import UIKit
import JGProgressHUD

class choiseViewController: UIViewController {

    
    private let spinner = JGProgressHUD(style: .dark)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "choback")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        //addsubviews
        view.addSubview(scrollView)
    }
   
    
    @IBAction func findRooms(_ sender: Any) {
        performSegue(withIdentifier: "toFindRooms", sender: nil)
    }
    
    @IBAction func findRoommates(_ sender: Any) {
        performSegue(withIdentifier: "toFindRoommate", sender: nil)
    }
    
    @IBAction func checkRooms(_ sender: Any) {
        performSegue(withIdentifier: "toCheckRooms", sender: nil)

    }
    
    @IBAction func toCheckRoommates(_ sender: Any) {
        performSegue(withIdentifier: "toCheckRoommates", sender: nil)
    }
}
