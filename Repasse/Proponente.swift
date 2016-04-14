//
//  Proponente.swift
//  Repasse
//
//  Created by Ricardo Gayer on 4/13/16.
//  Copyright © 2016 Ricardo Gayer. All rights reserved.
//

import UIKit

class Proponente: NSObject {
    
    let id_proponente:String
    let proponente:String
    let endereco:String
    let bairro:String
    let cidade:String
    let estado:String
    let cep:String
    let administracao:String
    let respons_proponente:String
    let cargo_respons_proponente:String
    
    init(id_proponente:String, proponente:String, endereco:String, bairro:String, cidade:String,
         estado:String, cep:String, administracao:String, cargo_respons_proponente:String, respons_proponente:String) {
        self.id_proponente = id_proponente
        self.proponente = proponente
        self.endereco = endereco
        self.bairro = bairro
        self.cidade = cidade
        self.estado = estado
        self.cep = cep
        self.administracao = administracao
        self.respons_proponente = respons_proponente
        self.cargo_respons_proponente = cargo_respons_proponente
                super.init()
    }

}
