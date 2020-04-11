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

class GoogleLoginViewController: UIViewController, GIDSignInDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
//        GIDSignIn.sharedInstance()?.signIn()
        
        let gSignIn = GIDSignInButton(frame: CGRect(x: 0, y: 0, width: 230, height: 40))
        gSignIn.center = view.center
        view.addSubview(gSignIn)
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
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
        if let error = error {
            print("\(error.localizedDescription)")
            //          return
        } else {
            let userId = user.userID
            let idToken = user.authentication.idToken
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print(fullName ?? "nil full name")
            print(userId as Any)
            print(idToken as Any)
            print(givenName as Any)
            print(familyName as Any)
            print(email as Any)
        }
        
        //Firebase sign in
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Firebase Sign in error")
                print(error.localizedDescription)
            } else {
                print("Login Successful.")
                //This is where you should add the functionality of successful login
                //i.e. dismissing this view or push the home view controller etc
                
                let newViewController = ProfileViewController()
                self.navigationController?.pushViewController(newViewController, animated: true)
                
                
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
        }
    }
    
}
