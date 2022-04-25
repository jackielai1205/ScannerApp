//
//  DeleteModelResponse.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 24/4/2022.
//

import Foundation

struct DeletResponse:Codable{
    var code:Int
    var message:String
    
    init(){
        code = -1
        message = ""
    }
}
