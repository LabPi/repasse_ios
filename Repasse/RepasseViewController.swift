//
//  RepasseViewController.swift
//  Repasse
//
//  Created by Ricardo Gayer on 4/12/16.
//  Copyright © 2016 Ricardo Gayer. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MBProgressHUD

var proponenteSelecionado:AggregateProponente!

class RepasseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var repasses:[Repasse] = [Repasse]()
    var arrRes = [[String:AnyObject]]()
    var proponente:Proponente!
    @IBOutlet weak var tx_endereco: UILabel!
    
    @IBOutlet weak var tx_proponente: UILabel!
    @IBOutlet weak var tx_administracao: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var repasse = [String]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tx_proponente.text = proponenteSelecionado.proponente
        tx_administracao.text = proponenteSelecionado.administracao
    
        self.title = "Convênios"
        
        getProponente()
        
        let spiningAlert = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let url:String = "http://repasse.cfapps.io/repasse/proponente/\(proponenteSelecionado.id_proponente)"
        
        Alamofire.request(.GET, url, parameters: nil)
            .responseJSON { response in
                
                let swiftyJsonVar = JSON(response.result.value!)
                
                if let resData = swiftyJsonVar.arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                }
                
                for a in self.arrRes {
                    
                    let dateFormatter = NSDateFormatter()
                    
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    
                    let repasse:Repasse = Repasse(
                        convenio:a["convenio"] as! Int,
                        administracao:a["administracao"] as! String,
                        valor:a["valor"] as! Double,
                        assinatura:dateFormatter.dateFromString(a["assinatura"] as! String)!,
                        cep:a["cep"] as! String,
                        estado:a["estado"] as! String,
                        cidade:a["cidade"] as! String,
                        id_proponente:a["id_proponente"] as! String,
                        proponente:a["proponente"] as! String,
                        situacao:a["situacao"] as! String,
                        orgao_superior:a["orgao_superior"] as! String,
                        orgao_concedente:a["orgao_concedente"] as! String,
                        programa:a["programa"] as! String,
                        objeto_convenio:a["objeto_convenio"] as! String,
                        justificativa:a["justificativa"] as! String,
                        endereco:a["endereco"] as! String,
                        bairro:a["bairro"] as! String,
                        respons_proponente:a["respons_proponente"] as! String,
                        cargo_respons_proponente:a["cargo_respons_proponente"] as! String,
                        respons_concedente:a["respons_concedente"] as! String,
                        cargo_respons_concedente:a["cargo_respons_concedente"] as! String
                    )
                    
                    self.repasses.append(repasse)
                }
                self.tableView.reloadData()
                spiningAlert.hide(true)
        }
        
        
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repasses.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("repasse", forIndexPath: indexPath)
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.stringFromDate(repasses[indexPath.row].assinatura)
        cell.textLabel?.text = dateString + "  " +  repasses[indexPath.row].valorReal!
        cell.detailTextLabel?.text = "Convênio: " + String(repasses[indexPath.row].convenio)
        return cell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let row = self.tableView.indexPathForSelectedRow?.row
        detalhe = repasses[row!]
    }
    
    
    func getProponente() {
        
       let spiningAlert = MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let url:String = "http://repasse.cfapps.io/proponente/\(proponenteSelecionado.id_proponente)"
        
        Alamofire.request(.GET, url, parameters: nil)
            .responseJSON { response in
                
                let j = JSON(response.result.value!)
                
                self.proponente = Proponente(
                    id_proponente:j["id_proponente"].string!,
                    proponente:j["proponente"].string!,
                    endereco:j["endereco"].string!,
                    bairro:j["bairro"].string!,
                    cidade:j["cidade"].string!,
                    estado:j["estado"].string!,
                    cep:j["cep"].string!,
                    administracao:j["administracao"].string!,
                    cargo_respons_proponente:j["cargo_respons_proponente"].string!,
                    respons_proponente:j["respons_proponente"].string!)
                
                
                self.tx_endereco.text = self.proponente.endereco
                
                spiningAlert.hide(true)
              
        }
        
        
        
    }

}
