//
//  NavControllerViewController.swift
//  MainPractice
//
//  Created by Alexander Castillo on 3/8/21.
//

import UIKit

class NavViewController: UIViewController {
    
    var modalview = ModalViewController()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Navigation"
       
        var button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x: self.view.center.x - 100, y: self.view.center.y - 300, width: 200, height: 100)
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(buttonaction(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
    }
    
    @objc func buttonaction(_ sender:UIButton) {
        modalview.modalPresentationStyle = .fullScreen
        self.present(modalview, animated: true)
        print("Button tapped!")
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
