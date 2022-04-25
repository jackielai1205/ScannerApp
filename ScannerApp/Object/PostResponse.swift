//
//  PostResponse.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 23/4/2022.
//

import Foundation

struct PostResponse:Codable{
    var code:Int
    var message:String
    var tranID:Int
}
