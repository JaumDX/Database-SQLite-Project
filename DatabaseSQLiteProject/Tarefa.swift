//
//  Tarefa.swift
//  DatabaseSQLiteProject
//
//  Created by Solid Jaum on 20/06/17.
//  Copyright © 2017 Time dos Sonhos. All rights reserved.
//

import Foundation

class Tarefa {
    
    let id: Int64?
    var descricao: String
    var nome: String
    var data: Date?
    
    
    
    init(id : Int64) {
        self.id = id
        self.descricao = ""
        self.nome = ""
        
    }
    
    init(id : Int64, nome : String,  descricao : String, data : Date) {
        self.id = id
        self.descricao = descricao
        self.nome = nome
        self.data = data
    }
    
}
