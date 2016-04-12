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

    init(convenio:Int, administracao:String, valor:Double, assinatura:NSDate) {
        self.convenio = convenio
        self.administracao = administracao
        self.valor = valor
        self.assinatura = assinatura
        super.init()
    }
    
    var valorReal: String? {
        let fmt = NSNumberFormatter()
        fmt.numberStyle = .CurrencyStyle
        fmt.locale = NSLocale(localeIdentifier: "pt_BR")
        return fmt.stringFromNumber(valor)
    }
    
}
