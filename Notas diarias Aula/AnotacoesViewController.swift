//
//  AnotacoesViewController.swift
//  Notas diarias Aula
//
//  Created by Fagner Caetano on 19/10/20.
//

import UIKit
import CoreData

class AnotacoesViewController: UIViewController {

    @IBOutlet weak var texto: UITextView!

    var context: NSManagedObjectContext!
    var anotacao: NSManagedObject!
    
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.texto.becomeFirstResponder()
        if anotacao != nil {
            guard let textoRecuperado = anotacao.value(forKey: "texto") else { return }
            self.texto.text = String(describing: textoRecuperado)
        } else {
            self.texto.text = ""
        }
    
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
    }
        
        @IBAction func salvar(_ sender: Any) {
            
            
            if anotacao != nil { //atualizar
                self.atualizarAnotacao()
            }else{
                self.salvarAnotacao()
            }
            
            //Retorna para a tela inicial
            self.navigationController?.popViewController(animated: true)
            
        }
        
    func atualizarAnotacao() {
        
        anotacao.setValue(self.texto.text, forKey: "texto")
        anotacao.setValue(Date(), forKey: "data")
        
            do {
                try context.save()
                print("Sucesso ao atualizar anotacao")
            } catch let erro {
                print("Erro ao salvar: \(erro.localizedDescription)")
            }
        
    }
        
        func salvarAnotacao() {
            //cria objeto para anotacao
            let novaAnotacao = NSEntityDescription.insertNewObject(forEntityName: "Anotacao", into: context)
            
            //configura anotacao
            novaAnotacao.setValue(self.texto.text, forKey: "texto")
            novaAnotacao.setValue(Date(), forKey: "data")
            
            do {
                try context.save()
                print("Sucesso ao salvar anotacao")
            } catch let erro {
                print("Erro ao salvar: \(erro.localizedDescription)")
            }
            
        }
        
        
        
    
    

    
    

}
