//
//  QueryUserResponse.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 22/4/2022.
//

import Foundation

struct QueryUserResponse: Codable{
    var code:Int
    var message:String
    var trans:[TransactionsData]
    
    init(){
        code = 0
        message = ""
        trans = [TransactionsData]()
    }
}
