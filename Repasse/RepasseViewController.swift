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

var proponenteSelecionado:Proponente!

class RepasseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var repasses:[Repasse] = [Repasse]()
    var arrRes = [[String:AnyObject]]()
    
    @IBOutlet weak var tx_proponente: UILabel!
    @IBOutlet weak var tx_administracao: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var repasse = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tx_proponente.text = proponenteSelecionado.proponente
        tx_administracao.text = proponenteSelecionado.administracao
    
        self.title = "Convênios"
        
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
                        assinatura:dateFormatter.dateFromString(a["assinatura"] as! String)!
                    )
                    
                    self.repasses.append(repasse)
                }
                self.tableView.reloadData()
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

}
