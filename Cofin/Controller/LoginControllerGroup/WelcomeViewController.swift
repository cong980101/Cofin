//
//  WelcomeViewController.swift
//  Cofin
//
//  Created by Cong on 2020/11/14.
//

import UIKit
import Firebase
import FirebaseAuth
import GoogleSignIn

class WelcomeViewController: UIViewController {
    
    //Google Login
    @IBAction func googleLogin(_sender: UIButton){
        GIDSignIn.sharedInstance()?.signIn()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ""
        
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
       
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
extension WelcomeViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            return
        }
        guard let authentication = user.authentication else {
            
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        Auth.auth().signIn(with: credential) {(result, error) in
            if let error = error {
                print("Login Error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            
            
            
            
            
//            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView"){
//                let navigationController = UINavigationController(rootViewController: viewController)
//                navigationController.modalPresentationStyle = .fullScreen
//                
//                self.present(navigationController, animated: true, completion: nil)
//                
//            }
            
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                
                UIApplication.shared.keyWindow?.rootViewController = viewController
                
                self.dismiss(animated: true, completion: nil)
            }
            
            /*
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let MainViewController = mainStoryBoard.instantiateViewController(withIdentifier: "MainView") as! MainTableViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = MainViewController
            
            self.dismiss(animated: true, completion: nil)
            */
            /*
            let mainTableviewController = MainTableViewController()
            let navigationController = UINavigationController(rootViewController: mainTableviewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
             */
        }
        
    }
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //
    }
}
