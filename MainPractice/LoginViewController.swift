//
//  LoginViewController.swift
//  MainPractice
//
//  Created by Alexander Castillo on 3/13/21.
//

import UIKit
import LocalAuthentication

class LoginViewController: UIViewController {
    var authenticated:Bool = false
    var useridtextbox:UITextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemGray

        let useridlable: UILabel = UILabel()
        useridlable.text = "USER ID:"
        useridlable.textColor = .black
        useridlable.font = .boldSystemFont(ofSize: 18)
        useridlable.textAlignment = .right
        self.view.addSubview(useridlable)
        
        useridlable.translatesAutoresizingMaskIntoConstraints = false
      //  useridlable.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        useridlable.centerXAnchor.constraint(equalTo: view.centerXAnchor,constant: -100).isActive = true
        useridlable.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100).isActive = true
        useridlable.widthAnchor.constraint(equalToConstant: 150).isActive = true
        useridlable.heightAnchor.constraint(equalToConstant: 50 ).isActive = true

        
        
       
        useridtextbox.placeholder = "enter user id"
        useridtextbox.font = .systemFont(ofSize: 18)
        useridtextbox.backgroundColor = .white
        self.view.addSubview(useridtextbox)
        useridtextbox.translatesAutoresizingMaskIntoConstraints = false
        useridtextbox.centerYAnchor.constraint(equalTo: useridlable.centerYAnchor).isActive = true
        useridtextbox.centerXAnchor.constraint(equalTo: useridlable.centerXAnchor, constant: 160).isActive = true
        useridtextbox.heightAnchor.constraint(equalToConstant: 30).isActive = true
        useridtextbox.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        let passwordlable: UILabel = UILabel()
        passwordlable.text = "PASSWORD:"
        passwordlable.textColor = .black
        passwordlable.textAlignment = .right
        passwordlable.font = .boldSystemFont(ofSize: 18)
        self.view.addSubview(passwordlable)
        
        passwordlable.translatesAutoresizingMaskIntoConstraints = false
      //  useridlable.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        passwordlable.centerXAnchor.constraint(equalTo: useridlable.centerXAnchor, constant: 0).isActive = true
        passwordlable.centerYAnchor.constraint(equalTo: useridlable.centerYAnchor, constant: 50).isActive = true
        passwordlable.widthAnchor.constraint(equalToConstant: 150).isActive = true
        passwordlable.heightAnchor.constraint(equalToConstant: 50 ).isActive = true

        
        
        let passwordtextbox:UITextField = UITextField()
        passwordtextbox.placeholder = "enter password"
        passwordtextbox.font = .systemFont(ofSize: 18)
        passwordtextbox.backgroundColor = .white
        self.view.addSubview(passwordtextbox)
        passwordtextbox.translatesAutoresizingMaskIntoConstraints = false
        passwordtextbox.centerYAnchor.constraint(equalTo: passwordlable.centerYAnchor).isActive = true
        passwordtextbox.centerXAnchor.constraint(equalTo: passwordlable.centerXAnchor, constant: 160).isActive = true
        passwordtextbox.heightAnchor.constraint(equalToConstant: 30).isActive = true
        passwordtextbox.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        var button:UIButton = UIButton(type:.system)
     //   button.frame = CGRect(x: self.view.center.x - 100, y: self.view.center.y - 300, width: 200, height: 100)
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(buttonaction(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerYAnchor.constraint(equalTo: passwordtextbox.centerYAnchor, constant: 50).isActive = true
        button.centerXAnchor.constraint(equalTo: passwordtextbox.centerXAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc func buttonaction(_ sender:UIButton) {
        if ((useridtextbox.text?.isEmpty) == nil) {
            useridtextbox.becomeFirstResponder()
            return
        }
        
        AppSettings.shared.settings = ["userid": String(useridtextbox.text ?? "")]
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
       

       startAuthentication()
    }
    
    func startAuthentication() {
        let context = LAContext()
        var autherror:NSError?
     
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &autherror) {
            context.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: "Access requires authentication",
                                   reply: {(success, error) in
                                    
                          DispatchQueue.main.async {
                              
                              if let err = error {
                                  
                                  switch err._code {
                                      
                                  case LAError.Code.systemCancel.rawValue:
                                      self.notifyUser("Session cancelled",
                                                      err: err.localizedDescription)
                                      
                                  case LAError.Code.userCancel.rawValue:
                                      self.notifyUser("Please try again",
                                                      err: err.localizedDescription)
                                      
                                  case LAError.Code.userFallback.rawValue:
                                      self.notifyUser("Authentication",
                                                      err: "Password option selected")
                                      // Custom code to obtain password here
                                      
                                  default:
                                      self.notifyUser("Authentication failed",
                                                      err: err.localizedDescription)
                                  }
                                self.view.alpha = 1
                                  
                              } else {
                                self.authenticated = true
                                   self.notifyUser("Authentication Successful",
                                                    err: "You now have full access")
                                    
                                //  self.dismiss(animated: true, completion: nil)
                              
                                  
                              }
                          }
                  })
           
       } else {
                print("biometrics unavailable")
        }
  }
    
    func notifyUser(_ msg: String, err: String?) {
        let alert = UIAlertController(title: msg,
            message: err,
            preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: self.dismissme)

        alert.addAction(cancelAction)

        self.present(alert, animated: true,
                            completion: nil)
    }

    
    
    func dismissme(_:UIAlertAction) {
        if authenticated {
            let appsetting = AppSettings.shared

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

}
