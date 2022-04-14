//
//  ModelDetail.swift
//  ScannerApp
//
//  Created by Jackie Tin Lok Lai on 13/4/2022.
//
struct ModelDetail:Decodable, Hashable{
    let modelid:Int
    let location:String
    let status:String
    let owner:String
    let receivetime:String
}
