//
//  Tarefa.swift
//  DatabaseSQLiteProject
//
//  Created by Solid Jaum on 20/06/17.
//  Copyright © 2017 Time dos Sonhos. All rights reserved.
//

import Foundation

class Tarefa {
    
    private let id: Int64?
    private var descricao: String
    
    
    
    init(id : Int64) {
        self.id = id
        self.descricao = ""
    }
    
    init(id : Int64, descricao : String) {
        self.id = id
        self.descricao = descricao
    }
    
}
