//
//  ProfileViewController.swift
//  CustomLogin
//
//  Created by Ilyasa' Azmi on 11/04/20.
//  Copyright © 2020 Ilyasa Azmi. All rights reserved.
//

import UIKit
import GoogleSignIn
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    var textLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let signOut = UIButton(frame: CGRect(x: 50, y: 50, width: 150, height: 50))
        signOut.backgroundColor = .black
        signOut.setTitle("Sign Out", for: .normal)
        signOut.center = view.center
        signOut.center.y = view.center.y + 100
        signOut.addTarget(self, action: #selector(self.signOut(_:)), for: .touchUpInside)
        signOut.layer.cornerRadius = signOut.frame.height / 2
        self.view.addSubview(signOut)

        // Do any additional setup after loading the view.
    }
    
    @objc func signOut(_ sender: UIButton) {
        print("Signing Out")
        GIDSignIn.sharedInstance()?.signOut()
        
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Failed to sign out")
            print(signOutError)
            return
        }
        
        print("Signed Out")
        self.navigationController?.popViewController(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
