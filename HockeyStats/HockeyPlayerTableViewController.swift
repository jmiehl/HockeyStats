//
//  HockeyPlayerTableViewController.swift
//  HockeyStats
//
//  Created by Joe Miehl on 1/24/24.
//

import UIKit

class HockeyPlayerTableViewController: UITableViewController {
    
    @IBOutlet weak var hockeyPlayersTableView: UITableView!
    
    var hockeyPlayers = [HockeyPlayer]()
    
    /* initial data set
     = [
     HockeyPlayer(firstName: "Kappo", lastName: "Kakko", goals: 3, assists: 1, points: 4, pointsPerGame: 0.1),
     HockeyPlayer(firstName: "Chris", lastName: "Krieder" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Artemi", lastName: "Panarin" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Vincent", lastName: "Trochek" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Adam", lastName: "Fox" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Alexis", lastName: "Lafreniere" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Erik", lastName: "Gustafsson" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Blake", lastName: "Wheeler" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Jacob", lastName: "Trouba" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "K'Andre", lastName: "Miller" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Jimmy", lastName: "Vesey" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Will", lastName: "Cuylie" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Braden", lastName: "Schneider" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Jonny", lastName: "Brodzinski" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Ryan", lastName: "Lindgren" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Filip", lastName: "Chytil" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Zac", lastName: "Jones" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Barclay", lastName: "Goodrow" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Nick", lastName: "Bonino" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25),
     HockeyPlayer(firstName: "Tyler", lastName: "Pitlick" , goals: 2, assists: 2, points: 4, pointsPerGame: 0.25)
     
     ]
     */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hockeyPlayersTableView.dataSource = self
        parseData()
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    
    @IBSegueAction func addEditHockeyPlayer(_ coder: NSCoder, sender: Any?) -> AddEditHockeyPlayerTableViewController? {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            let hockeyPlayerToEdit = hockeyPlayers[indexPath.row]
            return AddEditHockeyPlayerTableViewController(coder: coder, hockeyPlayers: hockeyPlayerToEdit)
        } else {
            return AddEditHockeyPlayerTableViewController(coder: coder, hockeyPlayers: nil)
        }
    }
    /*
     override func numberOfSections(in tableView: UITableView) -> Int {
     // #warning Incomplete implementation, return the number of sections
     return hockeyPlayers.count
     }
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return hockeyPlayers.count
    }
    
    func parseData() {
        hockeyPlayers = []
        
        let url = "https://api-web.nhle.com/v1/club-stats/nyr/20232024/2"
        
        var request = URLRequest(url: URL(string: url)!)
        
        request.httpMethod = "GET"
        
        let configuration = URLSessionConfiguration.default
        
        let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("Error")
            }
            else {
                do {
                    let fetchedData = try JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! NSDictionary
                    
                    
                    
                    if let rangersFetchedData = fetchedData["skaters"] as? [[String: Any]] {
                        for eachFetchedRanger in rangersFetchedData {
                            
                            
                            if let firstNameDict = eachFetchedRanger["firstName"] as? [String: Any]{
                                let firstName = firstNameDict["default"] as? String
                                let lastNameDict = eachFetchedRanger["lastName"] as? [String: Any]
                                let lastName = lastNameDict?["default"] as? String
                                let goals = eachFetchedRanger["goals"] as? Int
                                let assists = eachFetchedRanger["assists"] as? Int
                                let points = eachFetchedRanger["points"] as? Int
                                let position = eachFetchedRanger["positionCode"] as? String
                                let gamesPlayed = eachFetchedRanger["gamesPlayed"] as? Int
                                
                                self.hockeyPlayers.append(HockeyPlayer(firstName: firstName!, lastName: lastName!, position: position!, goals: goals!, assists: assists!, points: points!, gamesPlayed: gamesPlayed!))
                                
                            }
                            else {
                                print("Invalid Data Format")
                            }
                            self.tableView.reloadData()
                            // self.scheduleRecurringTask()
                        }
                    }
                } catch {
                    print("Error 2")
                }
            }
        }
        task.resume()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HockeyPlayerCell", for: indexPath) as! hockeyPlayerTableViewCell
        
        // fetch model object to display
        let hockeyPlayer = hockeyPlayers[indexPath.row]
        
        // Configure Cell
        cell.update(with: hockeyPlayer)
        cell.showsReorderControl = true
        
        // return cell
        return cell
    }
    /* not needed due to using the cell to navigate to the navigation controller
     override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     let hockeyPlayer = hockeyPlayers[indexPath.row]
     print("\(hockeyPlayer.firstName) \(indexPath)")
     }
     */
    
    @IBAction func editButtonTapped(_ sender: Any) {
        let tableViewEditingMode = tableView.isEditing
        
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let movedPlayer = hockeyPlayers.remove(at: fromIndexPath.row)
        hockeyPlayers.insert(movedPlayer, at: to.row)
        
    }
    
    @IBAction func unwindToHockeyPlayerTableView(unwindSegue: UIStoryboardSegue) {
        
    }
    

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
