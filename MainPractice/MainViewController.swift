//
//  MainViewController.swift
//  MainPractice
//
//  Created by Alexander Castillo on 3/8/21.
//

import UIKit
import LocalAuthentication

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    var authenticate:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        title = "Main"
        setupTabViews()
        
      
       
    
       //  startAuthentication()
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (authenticate) {
          let login = LoginViewController()
          login.modalPresentationStyle = .fullScreen
          self.present(login, animated: true)
          authenticate = false
        }
        print (AppSettings.shared.settings)
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

