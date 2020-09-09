//
//  ViewController.swift
//  sorteador de grupos
//
//  Created by Bryan Barreto on 05/09/20.
//  Copyright © 2020 Bryan Barreto. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var spinner: UIPickerView!
    @IBOutlet weak var textArea: UITextView!
    @IBOutlet weak var btnSortear: UIButton!
    @IBOutlet weak var btnResetar: UIButton!
    
    let spinnerData:[Int] = [2,3,4,5,6,7,8,9,10]
    var spinnerSelectedIndex:Int = 0
    
    let allStudents = "AITCHEOU GAUTHIER ZOUNTCHEGNON \n André Lucas Pereira Venceslau \n Benício Matheus Rodrigues \n Bruna Tokie Ebina \n Bruno Diegues \n Bruno Fonseca \n Bruno Freire da Silva \n Bruno Nascimento \n Bryan Barreto \n Carla Mendanha \n Catia Souza \n Dayana Prado \n Dominique N Bezerra \n Erik Radicheski da Silva \n Fernando de Cerqueira Crelick \n Gabriel Duarte \n Gustavo Ferreira \n Guto Rocha \n João Pedro Giarrante \n Juan Souza \n Junior Fernandes \n Karen Makihara \n Letícia Câmara \n Lidiane Gomes Barbosa \n Lucas Santiago do Nascimento \n Luciano araujo do cabo pinho \n Marcelo Buligon \n Matheus Bastelli Grigoletto \n Nathália Santos \n Patrícia Cardozo \n Paulo Vieira \n Rafael Nascimento Sampaio \n Rafael V dos Santos \n Renan Vicente de Farias \n Renato \n Rhenan \n Rodolpho Maia \n Rodrigo Cesar Ventura da Silva \n Sandyara Peres \n SouBrunoHorta \n Thais Nicodemus \n Thiago Messa \n Timoteo Holanda \n Tulio Smelo90 \n Vanessa Montagner"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnSortear.layer.cornerRadius = 20
        btnResetar.layer.cornerRadius = 20
        
        textArea.isEditable = true
        
        textArea.text = self.allStudents
        
        self.spinner.delegate = self
        self.spinner.dataSource = self
        
    }
    
    @IBAction func btnCloseKeyboard(_ sender: Any) {
        textArea.endEditing(true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return spinnerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(spinnerData[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.spinnerSelectedIndex = row
    }
    
    @IBAction func btnResetarPressed(_ sender: UIButton) {
        
        self.changeBtnSortear(isEnabled: true)
        
        textArea.text = self.allStudents
        
        textArea.isEditable = true
        textArea.isSelectable = true
    }
    
    @IBAction func btnSortearPressed(_ sender: UIButton) {
        
        let qtdGrupo:Int = self.spinnerData[self.spinnerSelectedIndex]
        var nomes:[String] = textArea.text.components(separatedBy: "\n")
        
        if(nomes.count % qtdGrupo != 0){
            print("quantidade de membros: \(nomes.count)")
            print("quantidade de grupos: \(qtdGrupo)")
            
            presentAlert(title: "Ops", message: "Total de alunos: \(nomes.count)\nTotal de Grupos: \(qtdGrupo)\nA quantidade de alunos por grupo não é exata!", buttonText: "Ok")
            
            
            
        }else{
            
            self.changeBtnSortear(isEnabled: false)
            
            textArea.isEditable = false
            textArea.isSelectable = false
            
            let membersPerGroup = nomes.count/qtdGrupo
            var finalText:String = ""
            
            for i in 0..<qtdGrupo{ // for 1 que cria os grupos
                
                finalText += "\(i+1)º GRUPO\n\n"
                
                for j in 0..<membersPerGroup { // for 2 que adiciona os alunos ao grupo
                    
                    /* sorteia um membro do array, pega o índice dele e remove do array */
                    let randomMember = nomes.randomElement()
                    let index = nomes.firstIndex(of: randomMember!)!
                    nomes.remove(at: index)
                    
                    /* adiciona o membro sorteado à string final */
                    finalText += "  \(j+1)º - \(randomMember!) \n"
                    
                } // end for 2
                
                finalText += "\n \n \n" // quebra de linha entre um grupo e outro
                
            } // end for 1
            
            textArea.text = finalText
            
        }
        
    }
    
    func presentAlert(title:String, message:String, buttonText:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: buttonText, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func changeBtnSortear(isEnabled: Bool){
        self.btnSortear.isEnabled = isEnabled
        
        if(isEnabled){
            btnSortear.backgroundColor = .black
        }else{
            btnSortear.backgroundColor = .gray
        }
    }
}

