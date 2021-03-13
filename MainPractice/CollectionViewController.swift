//
//  CollectionViewController.swift
//  MainPractice
//
//  Created by Alexander Castillo on 3/8/21.
//

import UIKit

class CollectionViewController: UIViewController,  UICollectionViewDelegate, UICollectionViewDataSource {
  
    
 
    var collectionview:UICollectionView?
    var images = ["meats", "pasta", "salads", "peppers", "soups"]
    var detailview:DetaiViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        title = "Collections"
        
        setupCollectionView()
        
    }
    

    func setupCollectionView() {
        
        self.view.backgroundColor = .white
        self.title = "Collection"
        self.navigationItem.title = "Collection"
       
       
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width:300, height: 100)
       
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        collectionview.backgroundColor = UIColor.white
        self.view.addSubview(collectionview)
        
        // setup constraints
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        collectionview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        collectionview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        collectionview.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
     //   collectionview.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
      
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        myCell.backgroundColor = UIColor.white
    
       let imageview  = UIImageView(image: UIImage(named: images[indexPath.row]))
       imageview.contentMode = .scaleAspectFill
       imageview.clipsToBounds = true
       imageview.layer.masksToBounds = true
       imageview.layer.cornerRadius = 7.0
        
        imageview.translatesAutoresizingMaskIntoConstraints = false
      //  imageview.topAnchor.constraint(equalTo: myCell.topAnchor).isActive = true
        //imageview.centerXAnchor.constraint(equalTo: myCell.centerXAnchor).isActive = true
        //imageview.centerYAnchor.constraint(equalTo: myCell.centerYAnchor).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: myCell.frame.size.width).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: myCell.frame.size.height).isActive = true
        
       let tapgesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped(sender:)))
       imageview.isUserInteractionEnabled = true
       imageview.tag = indexPath.row
       imageview.addGestureRecognizer(tapgesture)
        
       
        
       myCell.addSubview(imageview)
        
      return myCell
    }
  
    @objc func imageTapped(sender: UITapGestureRecognizer) {
        let detailview = DetaiViewController()
        self.navigationController?.pushViewController(detailview, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
       print("User selected on item \(indexPath.row)")
     
       
    }

    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        self.collectionview?.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
      //  self.collectionview?.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        self.collectionview?.setNeedsLayout()
        self.collectionview?.setNeedsDisplay()
    }
      
      
    override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }
}
