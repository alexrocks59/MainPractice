//
//  ModalViewController.swift
//  MainPractice
//
//  Created by Alexander Castillo on 3/8/21.
//

import UIKit

class ModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemTeal
        var button:UIButton = UIButton(type:.system)
        button.frame = CGRect(x: self.view.center.x - 100, y: self.view.center.y, width: 200, height: 100)
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(buttonaction(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        // Do any additional setup after loading the view.
    }
    

    @objc func buttonaction(_ sender:UIButton) {
        self.dismiss(animated: true, completion: nil)
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
