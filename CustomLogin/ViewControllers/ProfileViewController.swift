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
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
        
        let signOut = UIButton(frame: CGRect(x: 50, y: 50, width: 100, height: 30))
        signOut.backgroundColor = .red
        signOut.setTitle("Sign Out", for: .normal)
        signOut.center = view.center
        signOut.center.y = view.center.y + 100
        signOut.addTarget(self, action: #selector(self.signOut(_:)), for: .touchUpInside)
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
        
        if(GIDSignIn.sharedInstance()?.currentUser != nil)
        {
            //logged in
            self.view.backgroundColor = .red
            print(GIDSignIn.sharedInstance()?.currentUser ?? "yes")
        }
        else
        {
            //not  logged in
            self.view.backgroundColor = .yellow
            print(GIDSignIn.sharedInstance()?.currentUser ?? "not yet")
        }
        
        print("Signed Out")
        let newViewController = GoogleLoginViewController()
        self.navigationController?.pushViewController(newViewController, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
