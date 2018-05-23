//
//  JuegosViewController.swift
//  coleccionDeJuegos
//
//  Created by Cristhian Gomez on 23/05/18.
//  Copyright © 2018 Cristhian Gomez. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate, UIPickerViewDataSource, UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    @IBOutlet weak var opciones: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    let tipos = ["MOBA", "RPG", "SHOOTER", "ADVENTURES"]
    @IBOutlet weak var eliminarB: UIButton!
    @IBOutlet weak var addActButton: UIButton!
    var juego:Juego? = nil
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    var image = UIImagePickerController()
    
    @IBAction func opcionOnclick(_ sender: Any) {
        pickerView.isHidden = true
        opciones.isHidden = true
        
        
    }
    
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return tipos.count
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let opcion = tipos[row]
    return opcion
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        opciones.setTitle(tipos[row], for: .normal)
        opciones.isHidden = false
        pickerView.isHidden = true 
    }
    
    
    
    
    
   
    @IBAction func eliminarBoton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
        
        
    }
    
    @IBAction func agregarTapped(_ sender: Any) {
        if(juego != nil){
            juego!.titulo = tituloTextField.text
        
            juego!.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as Data?
            juego!.tipo = opciones.currentTitle
            opciones.isHidden = false
            pickerView.isHidden = true
        }
        else{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let juego = Juego(context: context)
        juego.titulo = tituloTextField.text!
        juego.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as Data?
        juego.tipo   = opciones.currentTitle
        pickerView.isHidden = false
        opciones.isHidden = true
    }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func camaraTapped(_ sender: Any) {
        image.sourceType = .camera
        present(image, animated: true, completion: nil)
        
    }
    @IBAction func fotosTapped(_ sender: Any) {
        image.sourceType = .photoLibrary
        present(image, animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        image.delegate = self
        if (juego != nil){
            JuegoImageView.image = UIImage( data: (juego!.imagen!) as Data )
            tituloTextField.text = juego!.titulo
            addActButton.setTitle("Actualizar", for: .normal)
            
        }
        else{
            opciones.isHidden = true
            eliminarB.isHidden = true
        }
        // Do any additional setup after loading the view.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    let imagenSeleccionada = info[UIImagePickerControllerOriginalImage] as! UIImage
        JuegoImageView.image = imagenSeleccionada
        image.dismiss(animated: true, completion: nil)
    }


}
