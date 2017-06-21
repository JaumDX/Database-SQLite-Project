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
    
    private let tarefas = Table("contacts")
    private let id = Expression<Int64>("id") //NomeDaConstante = Expressao<Tipo>("NomeDaExpressao")
    private let nome = Expression<String>("nome")
    private let descricao = Expression<String>("descricao")
    private let data = Expression<Date>("data")
    
    
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
            try db!.run(tarefas.create(ifNotExists: true) { table in
                
                
                table.column(id, primaryKey: .autoincrement)
                table.column(nome)
                table.column(data)
                table.column(descricao)
                
                })
        } catch  {
            print("Unable to create a table.")
        }
        
        
    }
    
    
    //MARK: CRUD
    
    
    //Insert data
    func insert(cnome : String, cdescricao : String, cdata: Date){
        
        do {
            let id = try db!.run(tarefas.insert(nome <- cnome, descricao <- cdescricao, data <- cdata))
            print("Insert successful!!")
            print(id)
        } catch  {
            print("Couldn't insert at database.")
        }
        
    }
    
    
    
    //Get all data
    
    func getAll() -> [Tarefa]{
        
        var tarefas = [Tarefa]()
        
        do {
            for tarefa in try db!.prepare(self.tarefas){
                
                
                print("id: \(tarefa[id])   --   nome: \(tarefa[nome])  -- descricao: \(tarefa[descricao]) -- data: \(tarefa[data]))")
                
                tarefas.append(Tarefa(id: tarefa[id], nome: tarefa[nome], descricao: tarefa[descricao], data: tarefa[data]))
            
            }
            
            print("Success getting data.")
        } catch  {
            print("Couldn't find anything.")
        }
        
        
        return tarefas
        
    }
    
    
    //Delete data
    
    func delete(cid: Int64) -> Bool{
        
        do {
            
            let tarefa = tarefas.filter(id == cid)

            try db!.run(tarefa.delete())
            
            print("Delete successful!")
            
            return true
            
        } catch  {
            
            print("Couldn't delete anything")
            
            return false
        }
        
    }
    
    
    //Update
    
    func update(cid : Int64, novaTarefa : Tarefa){
        

        do {
            
            let tarefa = tarefas.filter(id == cid)
            
            
            if try db!.run(tarefa.update(nome <- novaTarefa.nome, descricao <- novaTarefa.descricao, data <- novaTarefa.data!)) > 0{
                
                print("Update successful.")
                
            }else{
                
                print("Couldn't find this item on database.")
            }
        } catch  {
            print("Couldn't update anything.")
        }

        
    }
    
    
    
}
