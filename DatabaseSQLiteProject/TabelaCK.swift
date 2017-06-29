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
    
    
    init() {
        
        
        
    }

    
    func insertNewToDo(nome: String, descricao : String, data : Date){
        
        let newToDo = CKRecord(recordType: "Teste")
        
        newToDo["Nome"] = nome as CKRecordValue
        
        print("Ta aqui")
        
        let publicData = CKContainer.default().privateCloudDatabase
        
        
        publicData.save(newToDo) { (record : CKRecord?, error :Error?) in
            if error == nil{
                print("Data stored in cloud")
            }
            
        }

    }
    

    
}
