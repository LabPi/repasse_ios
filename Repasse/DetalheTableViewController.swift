//
//  DetalheTableViewController.swift
//  Repasse
//
//  Created by Ricardo Gayer on 4/12/16.
//  Copyright © 2016 Ricardo Gayer. All rights reserved.
//

import UIKit

var detalhe:Repasse!

class DetalheTableViewController: UITableViewController {
    
    @IBOutlet weak var tx_convenio: UILabel!
    @IBOutlet weak var tx_administracao: UILabel!
    @IBOutlet weak var tx_assinatura: UILabel!
    @IBOutlet weak var tx_valor: UILabel!
    @IBOutlet weak var tx_situacao: UILabel!
    @IBOutlet weak var tx_justificativa: UITextView!
    @IBOutlet weak var tx_orgao_concedente: UILabel!
    @IBOutlet weak var tx_objeto_convenio: UITextView!
    @IBOutlet weak var tx_programa: UITextView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tx_convenio.text = String(detalhe.convenio)
        tx_administracao.text = detalhe.administracao
        tx_situacao.text = detalhe.situacao
        tx_orgao_concedente.text = detalhe.orgao_concedente
        tx_objeto_convenio.text = detalhe.objeto_convenio
        tx_programa.text = detalhe.programa
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        let dateString = dateFormatter.stringFromDate(detalhe.assinatura)

        tx_assinatura.text = dateString
        tx_valor.text = detalhe.valorReal
        
        tx_justificativa.text = detalhe.justificativa
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

}
