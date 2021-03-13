//
//  TableViewController.swift
//  MainPractice
//
//  Created by Alexander Castillo on 3/8/21.
//

import UIKit


class RestaurantModel: NSObject {
    var id = ""
    var name = ""
    var _description = ""
    var category = ""
}


class RestaurantList: NSObject {
    
    var restaurantlist:NSMutableArray = NSMutableArray()
    var count = 0
    
    func add(restaurant:RestaurantModel) {
        self.restaurantlist.add(restaurant)
        self.count+=1
    }
}


class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableview = UITableView()
    let myArray = ["First", "Second", "Third"]
    var detailView = DetaiViewController()
    var endpoint:String = "http://www.json-generator.com/api/json/get/bQwCjWxBDS"
    var restaurantlist:RestaurantList = RestaurantList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "Tables"

        setupTableView()

        // Do any additional setup after loading the view.
    }
    
    func setupTableView() {
        
        let width = self.view.frame.size.width
        var height = self.view.frame.size.height
        height -= 50
 
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableview.dataSource = self
        tableview.delegate = self
    
        view.addSubview(tableview)
        
        // set up layout constraints...
        tableview.translatesAutoresizingMaskIntoConstraints = false
        
        tableview.topAnchor.constraint(equalTo: view.topAnchor, constant: 5).isActive = true
        
        tableview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        tableview.widthAnchor.constraint(equalToConstant: width).isActive = true
        
        // tableview.heightAnchor.constraint(equalToConstant: height).isActive = true
      
        self.getResturantList(userCompletionHandler: { restlist, error in
            if (error != nil) {
                DispatchQueue.main.async {
                  let alert = UIAlertController(title: "Restaurant Service", message: error?.localizedDescription, preferredStyle: .alert)
                  alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                  self.present(alert, animated: true, completion: nil)
                }
                return
            }
            self.restaurantlist = restlist!
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
           
          })
    
                
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.navigationController?.pushViewController(detailView, animated: true)
           
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantlist.count
       // return myArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
       // cell.textLabel!.text = "\(myArray[indexPath.row])"
        let  restaurant = self.restaurantlist.restaurantlist[indexPath.row] as! RestaurantModel
        cell.textLabel?.text = restaurant.name
        cell.detailTextLabel?.text = restaurant._description
        return cell
    }

  
    
    func getResturantList(userCompletionHandler : @escaping (RestaurantList?, Error?) ->Void) {
        
        let notif = Notification.Name("servicenotification")
        
        NotificationCenter.default.post(name:notif, object: nil)
        
        let url = URL(string: endpoint)
        
        #if DEBUG
        let defaults = UserDefaults.standard
        let mocktest = defaults.bool(forKey: "mocktest")
        let mockfile = defaults.string(forKey: "mockfile")
        if mocktest {
            self.mockTestList(endpoint: mockfile!)
            userCompletionHandler(self.restaurantlist, nil)
            return
        }
        #endif
        
        // format header example
        var request = URLRequest(url:url!)
        request.httpMethod = "GET"
        request.setValue("myid", forHTTPHeaderField: "Login")
        request.setValue("password", forHTTPHeaderField: "Password")
        
       // request.httpMethod = "POST"
       // request.httpBody =
     
        let task1 =  URLSession.shared.dataTask(with: request) { (data, response, error) in
            print(data)
            print(response)
        }
        
        task1.resume()
        
        //------------------------
    
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { data, response, error -> Void in
           // self.delegate?.servicestarted()
            guard let data = data else {
                   print("URLSession dataTask error:", error ?? "nil")
                   userCompletionHandler(nil, error)
                   return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, AnyObject>]
                self.parse(jsondata:json!)
              //  self.delegate?.servicedone()
                NotificationCenter.default.post(name:notif, object: nil)
                userCompletionHandler(self.restaurantlist, nil)
              }
            catch {
                print(error.localizedDescription)
                userCompletionHandler(nil, error)
            }
        })
        task.resume()
        
           
    }
    
    
     func parse(jsondata:[[String:AnyObject]]) {
        restaurantlist = RestaurantList()
        for anItem in jsondata {
          let restaurant = RestaurantModel()
          restaurant.name = (anItem["name"] as AnyObject? as? String) ?? ""
          restaurant.id  =  (anItem["id"]  as AnyObject? as? String) ?? ""
          restaurant._description =  (anItem["description"]  as AnyObject? as? String) ?? ""
          restaurant.category =  (anItem["category"]  as AnyObject? as? String) ?? ""
          restaurantlist.add(restaurant: restaurant)
        }
    }
    
    
    private func mockTestList(endpoint:String) {
        
        let file = endpoint.split(separator: ".")
        let filename:String = String(file[0])
        
        let path = String(Bundle.main.path(forResource: filename, ofType: "json")!)
         print("mocktest")
         
         do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let json = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, AnyObject>]
                self.parse(jsondata: json!)
        }
        catch {
            print("mockTestList error!")
        }
        
    }


    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
   
      
        if UIDevice.current.orientation.isLandscape {
            tableview.widthAnchor.constraint(equalTo: self.view.widthAnchor)
          // tableview.widthAnchor.constraint(equalToConstant: self.view.frame.size.width)
            tableview.setNeedsLayout()
            tableview.setNeedsDisplay()
           print("Landscape width: \(self.view.frame.size.width)")
        }
        else {
           print("Portrait width: \(self.view.frame.size.height)")
        }
    }


}
