//
//  Repasse.swift
//  Repasse
//
//  Created by Ricardo Gayer on 4/12/16.
//  Copyright © 2016 Ricardo Gayer. All rights reserved.
//

import UIKit

class Repasse: NSObject {
    
    let convenio:Int
    let administracao: String
    let valor: Double
    let assinatura: NSDate
    let cep:String
    let estado:String
    let cidade:String
    let id_proponente:String
    let proponente:String
    let situacao:String
    let orgao_superior:String
    let orgao_concedente:String
    let programa:String
    let objeto_convenio:String
    let justificativa:String
    let endereco:String
    let bairro:String
    let respons_proponente:String
    let cargo_respons_proponente:String
    let respons_concedente:String
    let cargo_respons_concedente:String
    
    init(convenio:Int,
         administracao:String,
         valor:Double,
         assinatura:NSDate,
         cep:String,
         estado:String,
         cidade:String,
         id_proponente:String,
         proponente:String,
         situacao:String,
         orgao_superior:String,
         orgao_concedente:String,
         programa:String,
         objeto_convenio:String,
         justificativa:String,
         endereco:String,
         bairro:String,
         respons_proponente:String,
         cargo_respons_proponente:String,
         respons_concedente:String,
         cargo_respons_concedente:String) {
        self.convenio = convenio
        self.administracao = administracao
        self.valor = valor
        self.assinatura = assinatura
        self.cep = cep
        self.estado = estado
        self.cidade = cidade
        self.id_proponente = id_proponente
        self.proponente = proponente
        self.situacao = situacao
        self.orgao_superior = orgao_superior
        self.orgao_concedente = orgao_concedente
        self.programa = programa
        self.objeto_convenio = objeto_convenio
        self.justificativa = justificativa
        self.endereco = endereco
        self.bairro = bairro
        self.respons_proponente = respons_proponente
        self.cargo_respons_proponente = cargo_respons_proponente
        self.respons_concedente = respons_concedente
        self.cargo_respons_concedente = cargo_respons_proponente
    }
    
    var valorReal: String? {
        let fmt = NSNumberFormatter()
        fmt.numberStyle = .CurrencyStyle
        fmt.locale = NSLocale(localeIdentifier: "pt_BR")
        return fmt.stringFromNumber(valor)
    }
    
}