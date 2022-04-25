//
//  ModelDetail.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 13/4/2022.
//
struct ModelList:Codable{
    let userID:String
    let code:String
    let message:String
    let trans: [TransactionsData]
    
    init(){
        userID = ""
        code = ""
        message = ""
        trans = [TransactionsData]()
    }
}
