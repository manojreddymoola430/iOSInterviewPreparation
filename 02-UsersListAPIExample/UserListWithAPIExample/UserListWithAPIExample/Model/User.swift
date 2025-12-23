//
//  User.swift
//  UserListWithAPIExample
//
//  Created by Manoj Reddy on 12/22/25.
//
import SwiftUI

struct User: Decodable, Identifiable
{
    let login:String
    let id: Int
    let avatar_url:String
}
