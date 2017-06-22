//
//  TabelaCK.swift
//  DatabaseSQLiteProject
//
//  Created by Solid Jaum on 22/06/17.
//  Copyright © 2017 Time dos Sonhos. All rights reserved.
//

import Foundation
import CloudKit


class TabelaCK{
    
    static let shared : TabelaCK = TabelaCK()
    
    
    private let container = CKContainer.default()

    
    init() {
        
        
        
    }

    
    func insertNewToDo(tarefa : Tarefa){
        
        let newToDo = CKRecord(recordType: "Tarefa")
        
        newToDo["Tarefa"] = tarefa as? CKRecordValue
        
        let publicData = container.publicCloudDatabase
        publicData.save(newToDo) { (record : CKRecord?, error :Error?) in
            
            print("Data stored in cloud")
            
        }

    }
    

    
}
