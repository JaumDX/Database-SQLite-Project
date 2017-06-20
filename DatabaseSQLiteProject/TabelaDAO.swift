//
//  File.swift
//  DatabaseSQLiteProject
//
//  Created by Solid Jaum on 19/06/17.
//  Copyright © 2017 Time dos Sonhos. All rights reserved.
//

import Foundation
import SQLite

class TabelaDAO {
    
    static let shared : TabelaDAO = TabelaDAO() //Singleton
    
    private let db: Connection?   //Database Conection.
    
    
    //Database Expressions.
    
    private let contacts = Table("contacts")
    private let id = Expression<Int64>("id") //NomeDaConstante = Expressao<Tipo>("NomeDaExpressao")
    private let descricao = Expression<String>("descricao")
    
    
    private init(){
        
        
        //Search for the path of database.
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        
        //Try to do a connection.
        do {
            db = try Connection("\(path)/db.sqlite3")
        } catch  {
            db = nil
            print("Unable to conect the database.")
        }
        
        createTable() //Chama a funçao de criar a table
        
        
    }

    //Function to create a table
    
    func createTable(){
        
        /*
 
         If a table doesn't exists, it will create a new table and insert the following collumns. Each collumn initializate with a expression.
         
         */
        
        
        do {
            try db!.run(contacts.create(ifNotExists: true) { table in
                table.column(id, primaryKey: true)
                table.column(descricao)
                
                })
        } catch  {
            print("Unable to create a table.")
        }
        
        
    }
    
    
}
