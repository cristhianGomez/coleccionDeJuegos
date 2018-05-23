//
//  ViewController.swift
//  coleccionDeJuegos
//
//  Created by Cristhian Gomez on 23/05/18.
//  Copyright © 2018 Cristhian Gomez. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    var juegos:[Juego] = []
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        do{
            
            try juegos = context.fetch(Juego.fetchRequest())
            tableView.reloadData()
        }
        catch{}
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let juego = juegos[indexPath.row]
        performSegue(withIdentifier: "juegoSegue" , sender: juego)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let siguienteVC = segue.destination as! JuegosViewController
        siguienteVC.juego = sender as? Juego 
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return juegos.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let juego = juegos[indexPath.row]
        cell.textLabel?.text = juego.titulo
        cell.imageView?.image = UIImage(data: (juego.imagen!) as Data)
        return cell
    }
}

