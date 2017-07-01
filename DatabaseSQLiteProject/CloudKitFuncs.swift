//
//  CloudKitFuncs.swift
//  DatabaseSQLiteProject
//
//  Created by Solid Jaum on 30/06/17.
//  Copyright © 2017 Time dos Sonhos. All rights reserved.
//

import Foundation
import CloudKit


class CloudKitFuncs: NSObject {
    
    static let shared : CloudKitFuncs = CloudKitFuncs() //Singleton
    
    
    private var container = CKContainer.default().privateCloudDatabase
    
    
    //Inicializa o container.
    override init() {
        
        
        
    }
    
    
    //MARK: Save
    func save(nome : String, descricao : String, data : Date){
        
        let newToDo = CKRecord(recordType: "Tarefa")
        
        newToDo.setObject(nome as CKRecordValue, forKey: "Nome")
        
        newToDo.setObject(descricao as CKRecordValue, forKey: "Descricao")
        
        newToDo.setObject(data as CKRecordValue, forKey: "Data")
        
        container.save(newToDo) { (record : CKRecord?, error :Error?) in
            if error == nil{
                
                print("Data stored in cloud")
                
            }else{
                
                print(error!)
                
            }
        }
        
    }
    
    
    //MARK: Delete
    func deleta(nome : String, descricao : String, data : Date){
        
        let predicateNome = NSPredicate(format: "Nome == %@", argumentArray: [nome])
        let predicateDescricao = NSPredicate(format: "Descricao == %@", argumentArray: [descricao])
        //let predicateData = NSPredicate(format: "Data == %@", argumentArray: [data])
        let predicateC = NSCompoundPredicate(type: .and , subpredicates: [predicateNome, predicateDescricao])
        
        let query = CKQuery(recordType: "Tarefa", predicate: predicateC)
        
        container.perform(query, inZoneWith: nil) { (results : [CKRecord]?, error : Error?) in
            
            if error == nil{
                
                if (results?.count)! > 0{
                    
                    
                    let record = (results?.first!)!
                    
                    self.container.delete(withRecordID: record.recordID, completionHandler: { (result : CKRecordID?, error : Error?) in
                        
                        if error == nil{
                            
                            print("Delete in cloud successful")
                            
                            
                            
                        }else{
                            
                            print(error!)
                            
                        }
                    })
                    
                    
                }else{
                    
                    print("No data was found")
                    
                }
                
            }else{
                
                print(error!)
                
            }
            
        }
    }
    
    
    //MARK: Update
    func update(nome : String, descricao : String, data : Date, novaTarefa : Tarefa){
        
        let predicateNome = NSPredicate(format: "Nome == %@", argumentArray: [nome])
        let predicateDescricao = NSPredicate(format: "Descricao == %@", argumentArray: [descricao])
        //let predicateData = NSPredicate(format: "Data == %@", argumentArray: [data])
        let predicateC = NSCompoundPredicate(type: .and , subpredicates: [predicateNome, predicateDescricao])
        
        let query = CKQuery(recordType: "Tarefa", predicate: predicateC)
        
        container.perform(query, inZoneWith: nil) { (results : [CKRecord]?, error : Error?) in
            
            if error == nil{
                
                if  (results?.count)! > 0{
                    
                    let record = results?.first!
                    
                    record?.setObject(novaTarefa.nome as CKRecordValue?, forKey: "Nome")
                    record?.setObject(novaTarefa.data as CKRecordValue?, forKey: "Data")
                    record?.setObject(novaTarefa.descricao as CKRecordValue?, forKey: "Descricao")

                    self.container.save(record!, completionHandler: { (result : CKRecord?, error : Error?) in
                        
                        if error == nil{
                            
                            print("Data updated")
                            
                        }else{
                            
                            print(error!)
                        }
                    })
                    
                }else{
                    
                    print("No data was found.")
                }
                
            }else{
                
                print(error!)
                
            }
        
        }
        
    }
    
}
