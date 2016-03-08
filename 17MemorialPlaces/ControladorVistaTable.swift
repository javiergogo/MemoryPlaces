//
//  ControladorVistaTable.swift
//  17MemorialPlaces
//
//  Created by Javier Gomez on 12/1/15.
//  Copyright © 2015 Javier Gomez. All rights reserved.
//

import UIKit

//dectionary variable
var lugares = [Dictionary<String,String>()]

var activePlace = -1
class ControladorVistaTable: UITableViewController {
    
    @IBOutlet var memorialTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        if lugares.count == 1
        {
            lugares.removeAtIndex(0)
            
            lugares.append(["name":"Burj Khalifa","lat":"25.1972504","long":"55.2732284"])
        }
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // creamos una seccion
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //creamos 3 filas
        return lugares.count
    }
    


    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

        cell.textLabel?.text = lugares[indexPath.row]["name"]

        return cell
    }

    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        activePlace = indexPath.row
        
        return indexPath
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "newPlace"
        {
            activePlace = -1
        }
        
    }
    
    
    //intente por mi mismo primero y esta fue la soucion, enseguida este amigo sugirrio esto:
    //se ejectura poco antes de que aparezca
    override func viewWillAppear(animated: Bool) {
        tableView.reloadData()
    }
    
    //recargar 
    /*
    override func viewDidAppear(animated: Bool) {
        
        memorialTable.reloadData()
    }   */

  
}
