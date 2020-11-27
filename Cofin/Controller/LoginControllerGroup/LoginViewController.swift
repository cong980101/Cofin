//
//  LoginViewController.swift
//  Cofin
//
//  Created by Cong on 2020/11/14.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    @IBAction func login(_ sender: UIButton){
        guard let emailAddress = emailTextField.text, emailAddress != "", let password = passwordTextField.text, password != ""   else {
            let alertController = UIAlertController(title: "Login Error", message: "Both fields must not be blank.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        //call Firebase API
        Auth.auth().signIn(withEmail: emailAddress, password: password, completion: {(result, error) in
            if let error = error {
                let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                
                return
            }
            //email Verification
            guard let result = result, result.user.isEmailVerified else {
                let alertController = UIAlertController(title: "Login Error", message: "You haven't confirmed your email address yet. We sent you a confirmation email when you sign up. Please click the verification link in that email. If you need us to send the confirmation email again, please tap Resend Email.", preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: {(action) in
                    Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                })
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)

                return
            }
            self.view.endEditing(true)
            
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView"){
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true, completion: nil)
            }
            /*
            if let viewController = self.storyboard?.instantiateViewController(withIdentifier: "MainView") {
                UIApplication.shared.keyWindow?.rootViewController = viewController
                self.dismiss(animated: true, completion: nil)
            }*/
            
            /*
            let mainTableviewController = MainTableViewController()
            let navigationController = UINavigationController(rootViewController: mainTableviewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
            */
            
        })
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
