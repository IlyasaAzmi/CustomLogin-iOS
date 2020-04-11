//
//  GoogleLoginViewController.swift
//  CustomLogin
//
//  Created by Ilyasa' Azmi on 10/04/20.
//  Copyright © 2020 Ilyasa Azmi. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class GoogleLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance()?.signIn()
        
        let gSignIn = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 230, height: 50))
        gSignIn.layer.cornerRadius = gSignIn.frame.height / 2
        gSignIn.center = view.center
        view.addSubview(gSignIn)
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSignIn), name: NSNotification.Name("SuccessfulSignInNotification"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
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
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    @objc func didSignIn()  {
        // Add your code here to push the new view controller
        navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
}
