//
//  SearchTableViewController.swift
//  DatabaseSQLiteProject
//
//  Created by Solid Jaum on 21/06/17.
//  Copyright © 2017 Time dos Sonhos. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController{
    
    //Variaveis uteis.
    var tarefas = [Tarefa]()
    
    
    //Outlets
    @IBOutlet var myTable: UITableView!
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        tarefas = TabelaDAO.shared.getAll()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return tarefas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        cell.textLabel?.text = tarefas[indexPath.row].nome

        return cell
    }

    
    
    // Delete the selected row from database.
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if TabelaDAO.shared.delete(cid: tarefas[indexPath.row].id!){
                
                tarefas.remove(at: indexPath.row)
                
                self.myTable.deleteRows(at: [indexPath], with: .fade)
                self.myTable.reloadData()
                
            }
            
        }
    }
    
    
    
    //Select a row for update data.
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let myVc = storyboard?.instantiateViewController(withIdentifier: "Cadastro") as! AddViewController
        
        myVc.edita = true
        myVc.id = tarefas[indexPath.row].id
        myVc.nome = tarefas[indexPath.row].nome
        myVc.descricao = tarefas[indexPath.row].descricao
        myVc.data = tarefas[indexPath.row].data
        
        
        self.navigationController?.pushViewController(myVc, animated: true)
        
        
        
    }

}
