//  BNResponse.swift
//  biin
//  Created by Esteban Padilla on 2/10/15.
//  Copyright (c) 2015 Esteban Padilla. All rights reserved.

import Foundation

class BNResponse:NSObject
{
    var code:Int?
    var responseDescription:String?
    var type:BNResponse_Type?
    
    override init() {
        super.init()
    }
    
    convenience init(code:Int, type:BNResponse_Type){
        self.init()
        self.code = code
        self.type = type
        addResponseDescription()
    }
    
    func addResponseDescription(){
        switch code! {
        case 0:
            responseDescription = NSLocalizedString("Cool", comment: "Cool")//"La solicitud fue exitosa"
            break
        case 1:
            responseDescription = NSLocalizedString("BadEmail", comment: "BadEmail")//"Correo o usuario ya existe"
            break
        case 2:
            responseDescription = NSLocalizedString("BadEmail", comment: "BadEmail")//"El formato es incorrecto"
            break
        case 3:
            responseDescription = NSLocalizedString("BadEmail", comment: "BadEmail")//"Hay campos requeridos"
            break
        case 4:
            responseDescription = NSLocalizedString("BadEmail", comment: "BadEmail")//"La longitud de los campos no es correcta"
            break
        case 5:
            responseDescription = NSLocalizedString("BadEmail", comment: "BadEmail")//"Error de bade de datos"
            break
        case 6:
            responseDescription = NSLocalizedString("BadEmail", comment: "BadEmail")//"Errores de validacion"
            break
        case 7:
            responseDescription = NSLocalizedString("BadEmail", comment: "BadEmail")//"El identificador proporcionado no correspondo con ningun registro"
            break
        case 8:
            responseDescription = NSLocalizedString("BadEmail", comment: "BadEmail")//Usuario o contrasenna no coinciden

            break
        case 9:
            responseDescription = NSLocalizedString("RequestFailed", comment: "RequestFailed")
            break
        case 10:
            responseDescription = NSLocalizedString("NotInternet", comment: "NotInternet")
            break
        default:
            responseDescription = NSLocalizedString("Cool", comment: "Cool")
            break
        }
    }
    
    deinit {
        
    }
}

enum BNResponse_Type {
    case Cool
    case Suck
    case RequestFailed
}