//
//  secondViewController.swift
//  My Diabetic Manager
//
//  Created by Emmanuele Montagna on 02/02/17.
//  Copyright © 2017 Vincenzo De Rosa. All rights reserved.
//

import UIKit

class secondViewController: UIViewController ,UITableViewDataSource, UITableViewDelegate{
    
    var lista=singola_pagina.nomeElemChecked
    
    
    @IBOutlet weak var dismissou: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        
    }
    
    @IBAction func dismissAction(_ sender: AnyObject) {
        self.dismiss(animated: true,completion: nil)
        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lista.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier="Cell"
        let cell=tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = lista[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            lista.remove(at: indexPath.row)
            if (contatori[singola_pagina.paginaCorrente]>0)
            {
                totali[singola_pagina.paginaCorrente]-=NSString(string: valore_tot).doubleValue
                contatori[singola_pagina.paginaCorrente]-=1
                visibleCounter-=1
                
                if !singola_pagina.nomeElemChecked.isEmpty {
                    singola_pagina.nomeElemChecked.removeLast()
                }
                
                
            }
        }
        
        
        
        
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    
    
}



