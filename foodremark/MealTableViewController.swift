//
//  MealTableViewController.swift
//  foodremark
//
//  Created by Apple24 on 19/4/29.
//  Copyright © 2019年 zhy. All rights reserved.
//

import UIKit
import os.log

class MealTableViewController: UITableViewController {

    var meals = [Meal]()
    @IBAction func unwindToMeal(sender:UIStoryboardSegue){
        if let sourceViewController = sender.source as? AddFoodCotroller,let meal = sourceViewController.meal{
            if let selectedIndexPath = tableView.indexPathForSelectedRow{
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else{
                let indexPath = IndexPath(row: meals.count, section: 0)
                meals.append(meal)
                
                self.tableView.insertRows(at: [indexPath], with: .automatic)
                
            }
            saveMeals()
            
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch segue.identifier! {
        case "addMeal":
            break
        case "showDetail":
            let DetailViewController:AddFoodCotroller = segue.destination as! AddFoodCotroller
            let indexPath = tableView.indexPath(for: sender as! MealTableViewCell)
            DetailViewController.meal = meals[indexPath!.row]
        default:
            break
        }
    }
    private func loadSamples(){
        let photo1 = #imageLiteral(resourceName: "meal1")
        let photo2 = #imageLiteral(resourceName: "meal2")
        let photo3 = #imageLiteral(resourceName: "meal3")
        
        let meal1 = Meal(name: "Salad", photo: photo1, rating: 4)!
        let meal2 = Meal(name: "Potato", photo: photo2, rating: 5)!
        let meal3 = Meal(name: "Mealball", photo: photo3, rating: 3)!
        meals += [meal1,meal2,meal3]
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        if let savedMeals = loadMeals(){
            meals += savedMeals
        }
        else{
            loadSamples()
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealTableViewCell", for: indexPath) as! MealTableViewCell
        

        // Configure the cell...
        let meal = meals[indexPath.row]
        cell.foodNameLabel.text = meal.name
        cell.FoodImage.image = meal.photo
        cell.rating.rating = meal.rating
        
        return cell
    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            saveMeals()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    private func saveMeals(){
        let isSucessfulSave = NSKeyedArchiver.archiveRootObject(meals, toFile: Meal.ArchiverURL.path)
        if isSucessfulSave == false{
            os_log("Failed to save meals",log:OSLog.default,type:.debug)
            
        }
    }
    private func loadMeals()->[Meal]?{
        return NSKeyedUnarchiver.unarchiveObject(withFile: Meal.ArchiverURL.path) as? [Meal]
    }
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
}
