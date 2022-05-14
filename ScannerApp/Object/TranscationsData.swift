//
//  TranscationsData.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 20/4/2022.
//

import Foundation

struct TransactionsData: Codable, Hashable{
    var tranID: Int
    var userID:String
    var location:String
    var date: String
    var time: String
    var modelName: String
    var status: Int
    var processTime:String?
    var imageLength:Int
}
