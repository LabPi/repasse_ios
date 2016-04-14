//
//  Proponente.swift
//  Repasse
//
//  Created by Ricardo Gayer on 4/11/16.
//  Copyright © 2016 Ricardo Gayer. All rights reserved.
//

import UIKit
import MapKit


class AggregateProponente: NSObject, MKAnnotation {
    
    let id_proponente: String
    let proponente: String
    let coordinate: CLLocationCoordinate2D
    let administracao: String
    let total: Double
    
    init(id_proponente:String, proponente:String, coordinate:CLLocationCoordinate2D, administracao:String, total:Double) {

        self.id_proponente = id_proponente
        self.proponente = proponente
        self.coordinate = coordinate
        self.administracao = administracao
        self.total = total
        super.init()
    }
    
    var title: String? {
        let fmt = NSNumberFormatter()
        fmt.numberStyle = .CurrencyStyle
        fmt.locale = NSLocale(localeIdentifier: "pt_BR")
        return fmt.stringFromNumber(total)
    }
    
    var subtitle: String? {
        return proponente
    }
    
}
