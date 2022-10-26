//
//  ViewController.swift
//  AppClima
//
//  Created by José Antonio Vieyra García on 21/09/22.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate
{
    
    var climaManager = ClimaManager()
    var Climas: Principal?
    
 
    @IBOutlet weak var ciudadTF: UITextField!
    @IBOutlet weak var condicionClimaImg: UIImageView!
    @IBOutlet weak var temperaturaLabel: UILabel!
    @IBOutlet weak var cuidadLabel: UILabel!
    @IBOutlet weak var TablaDatos: UITableView!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        TablaDatos.register(UINib(nibName: "CeldaTableViewCell", bundle: nil), forCellReuseIdentifier: "celda")
        
        climaManager.delegado = self
        ciudadTF.delegate = self
        TablaDatos.dataSource = self
        TablaDatos.delegate = self
    }
    @IBAction func buscarB(_ sender: UIButton)
    {
        ciudadTF.endEditing(true)
    }
    //MARK: - metodos del delegado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        //ocultar el teclado
        ciudadTF.endEditing(true)
        //MARK: - Acer bsuqueda en Api
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    {
        if ciudadTF.text != ""
        {
            return true
        }else{
            ciudadTF.placeholder = "Escribe algo.."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        climaManager.buscarClima(ciudad: ciudadTF.text!)
        cuidadLabel.text = ciudadTF.text
        //limpia el textField
        ciudadTF.text = ""
    }

}

extension ViewController: ClimaManagerDelegado,UITableViewDelegate, UITableViewDataSource{
    

func actualizarClima(clima: Principal) {
   Climas = clima
    DispatchQueue.main.async {
        
        let x:Principal = clima
        x.data.forEach{ obj in
      self.temperaturaLabel.text = obj.tempString
       self.cuidadLabel.text = clima.data[0].city_name
            self.condicionClimaImg.image = UIImage(systemName: clima.data[0].weather.condicionClima)
        }
        self.TablaDatos.reloadData()
    }
    
}
//MARK: -Tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Climas?.minutely.count ?? 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celda = TablaDatos.dequeueReusableCell(withIdentifier: "celda", for: indexPath)
        as! CeldaTableViewCell
        celda.timeTemp.text = "\(Climas?.minutely[indexPath.row].timestamp_utc ?? "")"
        celda.ts.text = "\(Climas?.minutely[indexPath.row].tsString ?? "")"
        return celda

    

}
    
}

