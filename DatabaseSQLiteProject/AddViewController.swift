//
//  AddViewController.swift
//  DatabaseSQLiteProject
//
//  Created by Solid Jaum on 20/06/17.
//  Copyright © 2017 Time dos Sonhos. All rights reserved.
//

import UIKit
import CloudKit

class AddViewController: UIViewController {
    
    
    //MARK: Outlets
    
    @IBOutlet weak var nomeTarefa: UITextField!
    @IBOutlet weak var descricaoTarefa: UITextView!
    @IBOutlet weak var dataLimite: UIDatePicker!
    @IBOutlet weak var cadastrarButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    
    
    //MARK: Variáveis Uteis
    
    /// Usada para saber quando o usuário pode dar update em um dado
    var edita = false
    var id : Int64? /// Variável que recebe valor de outra View
    var nome: String? /// Variável que recebe valor de outra View
    var descricao: String? /// Variável que recebe valor de outra View
    var data: Date? /// Variável que recebe valor de outra View
    
    
    
    ///Link para o database.
    let container = CKContainer.default().privateCloudDatabase
    
    
    //MARK: Funcoes
    
    
    ///View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVisual()   // Setup borders to some fields.
        dataLimite.minimumDate = Date()  // Set the actual date/time as minimum.
        
        if(edita){
            
            nomeTarefa.text = nome!
            descricaoTarefa.text = descricao!
            dataLimite.date = data!
            cadastrarButton.setTitle("Update", for: .normal)
            cancelButton.alpha = 0
            
        }
        
    }
    
    /**
     
     Define bordas lara botoes.
     
     */
    func setupVisual(){
        
        self.descricaoTarefa.layer.borderWidth = 1
        self.dataLimite.layer.borderWidth = 1
        self.cadastrarButton.layer.borderWidth = 1
        
    }
    
    /**
     Cancela uma adiçao.
     */
    @IBAction func cancelaAdd(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirstView") as! ViewController
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    
    
    /**
        Cadastra uma nova tarefa.
     */
    
    @IBAction func cadastraTarefa(_ sender: Any) {
        
        if !edita {  //Will insert a new to do
            if (nomeTarefa.text?.isEmpty)! || descricaoTarefa.text.isEmpty || dataLimite == nil{
                
                print("Nao pode inserir. Sem dados.")
                
            }else{
                
                //Insere no banco local
                TabelaDAO.shared.insert(cnome: nomeTarefa.text!, cdescricao: descricaoTarefa.text!, cdata: dataLimite.date)
                
                
                
                //Insere no Cloud Kitß
                CloudKitFuncs.shared.save(nome: nomeTarefa.text!, descricao: descricaoTarefa.text!, data: dataLimite.date)
                
                
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirstView") as! ViewController
                
                self.present(vc, animated: true, completion: nil)
                
            }
        }else{ // Will update.
            
            let novaTarefa = Tarefa(id: id!, nome: nomeTarefa.text!, descricao: descricaoTarefa.text!, data: dataLimite.date)
            
            
            print(id!)
            
            
            TabelaDAO.shared.update(cid: id!, novaTarefa: novaTarefa)
            
            CloudKitFuncs.shared.update(nome: nome!, descricao: descricao!, data: data!, novaTarefa: novaTarefa)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "FirstView") as! ViewController
            
            self.present(vc, animated: true, completion: nil)
            
        }
    }
    
    /**
     Faz algo quando solta o touch.
     */
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
