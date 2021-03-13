//
//  MainViewController.swift
//  MainPractice
//
//  Created by Alexander Castillo on 3/8/21.
//

import UIKit
import LocalAuthentication

class MainViewController: UITabBarController, UITabBarControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        title = "Main"
        setupTabViews()
        startAuthentication()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
       
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
                                  self.notifyUser("Authentication Successful",
                                                  err: "You now have full access")
                                  
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
            style: .cancel, handler: nil)

        alert.addAction(cancelAction)

        self.present(alert, animated: true,
                            completion: nil)
    }


    func setupTabViews() {
        
  
            
        self.tabBar.isTranslucent = false
        self.tabBar.barTintColor = UIColor(named: "Secondary")
   
        let rootVC = NavViewController()
        let tabOneView = UINavigationController(rootViewController: rootVC)
        tabOneView.navigationBar.isTranslucent = false
        tabOneView.navigationBar.barTintColor = UIColor(named: "Secondary")
        let tabOneBarItem = UITabBarItem(title: "Navigation", image: UIImage(systemName: "bolt"), selectedImage: UIImage(systemName: "bolt"))
        tabOneView.tabBarItem = tabOneBarItem
        
        
        let rootVC2 = TableViewController()
        let tabTwoView = UINavigationController(rootViewController: rootVC2)
        tabTwoView.navigationBar.isTranslucent = false
        tabTwoView.navigationBar.barTintColor = UIColor(named: "Secondary")
        let tabTwoBarItem = UITabBarItem(title: "Tables", image: UIImage(systemName: "bell"), selectedImage: UIImage(named: "bell"))
        tabTwoView.tabBarItem = tabTwoBarItem
        
        let rootVC3 = CollectionViewController()
        let tabThreeView = UINavigationController(rootViewController: rootVC3)
        tabThreeView.navigationBar.isTranslucent = false
        tabThreeView.navigationBar.barTintColor = UIColor(named: "Secondary")
        let tabThreeBarItem = UITabBarItem(title: "Collections", image: UIImage(systemName: "square.and.arrow.up"), selectedImage: UIImage(named: "square.and.arrow.up"))
        tabThreeView.tabBarItem = tabThreeBarItem
        
        let rootVC4 = MapViewController()
        let tabFourView = UINavigationController(rootViewController: rootVC4)
        tabFourView.navigationBar.isTranslucent = false
        tabFourView.navigationBar.barTintColor = UIColor(named: "Secondary")
        let tabFourBarItem = UITabBarItem(title: "Map", image: UIImage(systemName: "square.and.arrow.up"), selectedImage: UIImage(named: "square.and.arrow.up"))
        tabFourView.tabBarItem = tabFourBarItem
        
        
        self.viewControllers = [tabOneView, tabTwoView, tabThreeView, tabFourView]

    }
    
    // UITabBarControllerDelegate method
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
       // print("Selected \(viewController.title!) tab..")
    }
    
    
}

