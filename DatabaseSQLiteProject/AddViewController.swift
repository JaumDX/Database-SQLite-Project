//
//  AddViewController.swift
//  DatabaseSQLiteProject
//
//  Created by Solid Jaum on 20/06/17.
//  Copyright © 2017 Time dos Sonhos. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    
    //MARK: Outlets
    
    @IBOutlet weak var nomeTarefa: UITextField!
    @IBOutlet weak var descricaoTarefa: UITextView!
    @IBOutlet weak var dataLimite: UIDatePicker!
    @IBOutlet weak var cadastrarButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVisual()   // Setup borders to some fields.
        dataLimite.minimumDate = Date()  // Set the actual date/time as minimum.
        
    }
    
    
    
    //MARK: Setup Visual
    
    func setupVisual(){
        
        self.descricaoTarefa.layer.borderWidth = 1
        self.dataLimite.layer.borderWidth = 1
        self.cadastrarButton.layer.borderWidth = 1
        
    }
    
    
    
    
    
    
    
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
