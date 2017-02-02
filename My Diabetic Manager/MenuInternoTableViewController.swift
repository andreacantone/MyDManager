//
//  MenuInternoTableViewController.swift
//  Menu
//
//  Created by De Luca Raffaele on 28/01/17.
//  Copyright © 2017 iOSFoundation. All rights reserved.
//

import UIKit


class MenuInternoTableViewController: UITableViewController {
    
    
    var coursesName = ""
    var titles = ""
    
    struct firstCourse{
        let nome : String
        let immagine : String
    }
    struct secondCourse{
        let nome : String
        let immagine : String
    }
    struct drink{
        let nome : String
        let immagine : String
    }
    struct sideCourse{
        let nome : String
        let immagine : String
    }
    struct sandAndPizza{
        let nome : String
        let immagine : String
    }
    struct fruit{
        let nome : String
        let immagine : String
    }
    struct dessert{
        let nome : String
        let immagine : String
    }
    
    var firstCourses = [
        firstCourse(nome: "Boiled pasta", immagine: "1"),
        firstCourse(nome: "Rice salad", immagine: "4"),
        firstCourse(nome: "Lasagna", immagine: "9"),
        ]
    
    var secondCourses = [
        secondCourse(nome: "Roast chicken", immagine: "chicken"),
        secondCourse(nome: "Cutlet", immagine: "cotoletta"),
        secondCourse(nome: "Hamburger", immagine: "hamburger"),
        ]
    
    var drinks = [
        drink(nome: "Coffe", immagine: "coffe"),
        drink(nome: "Blonde beer", immagine: "beer"),
        drink(nome: "Coca Cola", immagine: "cocaCola"),
        ]
    
    var sideCourses = [
        sideCourse(nome: "Chickpeas", immagine: ""),
        sideCourse(nome: "Beans", immagine: ""),
        sideCourse(nome: "Peas", immagine: ""),
        ]
    
    var sandAndPizzas = [
        sandAndPizza(nome: "Cheesburger", immagine: ""),
        sandAndPizza(nome: "Pizza Margherita", immagine: ""),
        sandAndPizza(nome: "Hot Dog", immagine: ""),
        ]
    
    var fruits = [
        fruit(nome: "Watermelon", immagine: "watermelon"),
        fruit(nome: "Banana", immagine: "banana"),
        fruit(nome: "Orange", immagine: "orange"),
        ]
    
    var desserts = [
        dessert(nome: "Sicilian cassata", immagine: ""),
        dessert(nome: "Napolitan pastiera", immagine: ""),
        dessert(nome: "Chocolate croissant", immagine: ""),
        ]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var filteredFirstCourses = [firstCourse]()
    var filteredSecondCourses = [secondCourse]()
    var filteredDrinks = [drink]()
    var filteredSideCourses = [sideCourse]()
    var filteredSandAndPizzas = [sandAndPizza]()
    var filteredFruits = [fruit]()
    var filteredDesserts = [dessert]()
    
    
    
    func filteredContentForSearchText(searchText: String, scope: String = "All"){
        if coursesName == "First courses"{
            filteredFirstCourses = firstCourses.filter{firstCourse in
                return firstCourse.nome.lowercased().contains(searchText.lowercased())
            }
        }
        else if coursesName == "Desserts"{
            filteredDesserts = desserts.filter{dessert in
                return dessert.nome.lowercased().contains(searchText.lowercased())
            }
        }
        else if coursesName == "Second courses"{
            filteredSecondCourses = secondCourses.filter{secondCourse in
                return secondCourse.nome.lowercased().contains(searchText.lowercased())
            }
        }
        else if coursesName == "Drinks"{
            filteredDrinks = drinks.filter{drink in
                return drink.nome.lowercased().contains(searchText.lowercased())
            }
        }
        else if coursesName == "Side dishes"{
            filteredSideCourses = sideCourses.filter{sideCourse in
                return sideCourse.nome.lowercased().contains(searchText.lowercased())
            }
        }
        else if coursesName == "Sandwitches and pizzas"{
            filteredSandAndPizzas = sandAndPizzas.filter{sandAndPizza in
                return sandAndPizza.nome.lowercased().contains(searchText.lowercased())
            }
        }
        else if coursesName == "Fruits"{
            filteredFruits = fruits.filter{fruit in
                return fruit.nome.lowercased().contains(searchText.lowercased())
            }
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if searchController.isActive && searchController.searchBar.text != ""{
            if coursesName == "First courses"{
                return filteredFirstCourses.count
            }
            else if coursesName == "Second courses" {
                return filteredSecondCourses.count
            }
            else if coursesName == "Drinks"{
                return filteredDrinks.count
            }
            else if coursesName == "Side dishes"{
                return filteredSideCourses.count
            }
            else if coursesName == "Sandwitches and pizzas"{
                return filteredSandAndPizzas.count
            }
            else if coursesName == "Fruits"{
                return filteredFruits.count
            }
            else if coursesName == "Desserts"{
                return filteredDesserts.count
            }
            else {return 0}
        }
        
        if coursesName == "First courses"{
            return firstCourses.count
        }
        else if coursesName == "Second courses" {
            return secondCourses.count
        }
        else if coursesName == "Drinks"{
            return drinks.count
        }
        else if coursesName == "Side dishes"{
            return sideCourses.count
        }
        else if coursesName == "Sandwitches and pizzas"{
            return sandAndPizzas.count
        }
        else if coursesName == "Fruits"{
            return fruits.count
        }
        else if coursesName == "Desserts"{
            return desserts.count
        }
        else {return 0}
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "singleCourse"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! singleSourceTableViewCell
        
        var firstcourse : firstCourse?
        var secondcourse : secondCourse?
        var drink : drink?
        var sidecourse : sideCourse?
        var sandandpizza : sandAndPizza?
        var fruit : fruit?
        var dessert : dessert?
        
        if coursesName == "First courses"{
            if searchController.isActive && searchController.searchBar.text != ""{
                firstcourse = filteredFirstCourses[indexPath.row]
            }else{firstcourse = firstCourses[indexPath.row]}
        }
        if coursesName == "Second courses"{
            if searchController.isActive && searchController.searchBar.text != ""{
                secondcourse = filteredSecondCourses[indexPath.row]
            }else{secondcourse = secondCourses[indexPath.row]}
        }
        if coursesName == "Drinks"{
            if searchController.isActive && searchController.searchBar.text != ""{
                drink = filteredDrinks[indexPath.row]
            }else{drink = drinks[indexPath.row]}
        }
        if coursesName == "Side dishes"{
            if searchController.isActive && searchController.searchBar.text != ""{
                sidecourse = filteredSideCourses[indexPath.row]
            }else{sidecourse = sideCourses[indexPath.row]}
        }
        if coursesName == "Sandwitches and pizzas"{
            if searchController.isActive && searchController.searchBar.text != ""{
                sandandpizza = filteredSandAndPizzas[indexPath.row]
            }else{sandandpizza = sandAndPizzas[indexPath.row]}
        }
        if coursesName == "Fruits"{
            if searchController.isActive && searchController.searchBar.text != ""{
                fruit = filteredFruits[indexPath.row]
            }else{fruit = fruits[indexPath.row]}
        }
        if coursesName == "Desserts"{
            if searchController.isActive && searchController.searchBar.text != ""{
                dessert = filteredDesserts[indexPath.row]
            }else{dessert = desserts[indexPath.row]}
        }
        
        if coursesName == "First courses"{
            cell.SingleCourseName?.text = firstcourse?.nome
            cell.SingleCourseImage?.image = UIImage(named: (firstcourse?.immagine)!)
        }
        if coursesName == "Second courses"{
            cell.SingleCourseName?.text = secondcourse?.nome
            cell.SingleCourseImage?.image = UIImage(named: (secondcourse?.immagine)!)
        }
        if coursesName == "Side dishes"{
            cell.SingleCourseName?.text = sidecourse?.nome
            cell.SingleCourseImage?.image = UIImage(named: (sidecourse?.immagine)!)
        }
        if coursesName == "Drinks"{
            cell.SingleCourseName?.text = drink?.nome
            cell.SingleCourseImage?.image = UIImage(named: (drink?.immagine)!)
        }
        if coursesName == "Sandwitches and pizzas"{
            cell.SingleCourseName?.text = sandandpizza?.nome
            cell.SingleCourseImage?.image = UIImage(named: (sandandpizza?.immagine)!)
        }
        if coursesName == "Fruits"{
            cell.SingleCourseName?.text = fruit?.nome
            cell.SingleCourseImage?.image = UIImage(named: (fruit?.immagine)!)
        }
        if coursesName == "Desserts"{
            cell.SingleCourseName?.text = dessert?.nome
            cell.SingleCourseImage?.image = UIImage(named: (dessert?.immagine)!)
        }
        
        return cell
    }
    /*
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
     
     // Configure the cell...
     
     return cell
     }
     */
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
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
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "cibo"{
            if let indexPath = tableView.indexPathForSelectedRow{
                
                var appoggio_2 = ""
                let destinationController = segue.destination as!
                ViewController
                
                if coursesName == "First courses"{
                    if searchController.isActive && searchController.searchBar.text != ""{
                        appoggio_2 = filteredFirstCourses[indexPath.row].nome
                    }else{appoggio_2 = firstCourses[indexPath.row].nome}
                }
                if coursesName == "Second courses"{
                    if searchController.isActive && searchController.searchBar.text != ""{
                        appoggio_2 = filteredSecondCourses[indexPath.row].nome
                    }else{appoggio_2 = secondCourses[indexPath.row].nome}
                }
                if coursesName == "Drinks"{
                    if searchController.isActive && searchController.searchBar.text != ""{
                        appoggio_2 = filteredDrinks[indexPath.row].nome
                    }else{appoggio_2 = drinks[indexPath.row].nome}
                }
                if coursesName == "Side dishes"{
                    if searchController.isActive && searchController.searchBar.text != ""{
                        appoggio_2 = filteredSideCourses[indexPath.row].nome
                    }else{appoggio_2 = sideCourses[indexPath.row].nome}
                }
                if coursesName == "Sandwitches and pizzas"{
                    if searchController.isActive && searchController.searchBar.text != ""{
                        appoggio_2 = filteredSandAndPizzas[indexPath.row].nome
                    }else{appoggio_2 = sandAndPizzas[indexPath.row].nome}
                }
                if coursesName == "Fruits"{
                    if searchController.isActive && searchController.searchBar.text != ""{
                        appoggio_2 = filteredFruits[indexPath.row].nome
                    }else{appoggio_2 = fruits[indexPath.row].nome}
                }
                if coursesName == "Desserts"{
                    if searchController.isActive && searchController.searchBar.text != ""{
                        appoggio_2 = filteredDesserts[indexPath.row].nome
                    }else{appoggio_2 = desserts[indexPath.row].nome}
                }
                    destinationController.tupla.name = appoggio_2
                
            }
        }
        
    }
}

extension MenuInternoTableViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        filteredContentForSearchText(searchText:  searchController.searchBar.text!)
    }
}
