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
            responseDescription = "Cool"//"La solicitud fue exitosa"
            break
        case 1:
            responseDescription = "Bad email or password!"//"Correo o usuario ya existe"
            break
        case 2:
            responseDescription = "Bad email or password!"//"El formato es incorrecto"
            break
        case 3:
            responseDescription = "Bad email or password!"//"Hay campos requeridos"
            break
        case 4:
            responseDescription = "Bad email or password!"//"La longitud de los campos no es correcta"
            break
        case 5:
            responseDescription = "Bad email or password!"//"Error de bade de datos"
            break
        case 6:
            responseDescription = "Bad email or password!"//"Errores de validacion"
            break
        case 7:
            responseDescription = "Bad email or password!"//"El identificador proporcionado no correspondo con ningun registro"
            break
        case 8:
            responseDescription = "Bad email or password!"//Usuario o contrasenna no coinciden

            break
        case 9:
            responseDescription = "Request Failed!"
            break
        case 10:
            responseDescription = "Internet is not available!"
            break
        default:
            responseDescription = "Cool"
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