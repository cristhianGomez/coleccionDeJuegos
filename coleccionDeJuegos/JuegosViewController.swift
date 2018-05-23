//
//  JuegosViewController.swift
//  coleccionDeJuegos
//
//  Created by Cristhian Gomez on 23/05/18.
//  Copyright © 2018 Cristhian Gomez. All rights reserved.
//

import UIKit

class JuegosViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate{
    
    @IBOutlet weak var eliminarB: UIButton!
    
    @IBAction func eliminarBoton(_ sender: Any) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(juego!)
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        navigationController?.popViewController(animated: true)
        
        
        
    }
    @IBOutlet weak var addActButton: UIButton!
    var juego:Juego? = nil
    @IBOutlet weak var JuegoImageView: UIImageView!
    @IBOutlet weak var tituloTextField: UITextField!
    var image = UIImagePickerController()
    
    @IBAction func agregarTapped(_ sender: Any) {
        if(juego != nil){
            juego!.titulo = tituloTextField.text
        
            juego!.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as Data?
            
        }
        else{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let juego = Juego(context: context)
        juego.titulo = tituloTextField.text!
        juego.imagen = UIImagePNGRepresentation(JuegoImageView.image!) as Data?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        image.delegate = self
        if (juego != nil){
            JuegoImageView.image = UIImage( data: (juego!.imagen!) as Data )
            tituloTextField.text = juego!.titulo
            addActButton.setTitle("Actualizar", for: .normal)
            
        }
        else{
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
