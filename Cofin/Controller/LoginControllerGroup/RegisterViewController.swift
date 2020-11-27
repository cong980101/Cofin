//
//  RegisterViewController.swift
//  Cofin
//
//  Created by Cong on 2020/11/14.
//

import UIKit
import Firebase


class RegisterViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerButtonPressed(_sender: UIButton){
        guard let name = nameTextField.text, name != "", let emailAddress = emailTextField.text, emailAddress != "", let password = passwordTextField.text, password != ""  else {
            
            let alertController = UIAlertController(title: "Registration Error", message: "Please make sure you provide your name, email address and password to complete the registration.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(okayAction)
            present(alertController, animated: true, completion: nil)
            return
        }
        //Call Firebase API
        Auth.auth().createUser(withEmail: emailAddress, password: password, completion: {(user, error) in
            if let error = error{
                let alertController = UIAlertController(title: "Registration Error", message: error.localizedDescription, preferredStyle: .alert)
                let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(okayAction)
                self.present(alertController, animated: true, completion: nil)
                return
            }
            if let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest(){
                changeRequest.displayName = name
                changeRequest.commitChanges(completion: {(error) in
                    if let error = error{
                        print("Failed to change the display name: \(error.localizedDescription)")
                    }
                })
            }
            self.view.endEditing(true)
            
            //email Verification
            Auth.auth().currentUser?.sendEmailVerification(completion: {(error) in
                print("Fail to send verfication email")
            })
            let alertController = UIAlertController(title: "Eamil Verification", message: "Please make sure you provide your name, email address and password to complete the registration.", preferredStyle: .alert)
            let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: {(action) in
                self.dismiss(animated: true, completion: nil)
            })
            alertController.addAction(okayAction)
            self.present(alertController, animated: true, completion: nil)
            
            //to main view
            let mainTableviewController = MainTableViewController()
            let navigationController = UINavigationController(rootViewController: mainTableviewController)
            navigationController.modalPresentationStyle = .fullScreen
            self.present(navigationController, animated: true)
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
