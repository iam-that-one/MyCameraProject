//
//  Users.swift
//  TakePicture
//
//  Created by Abdullah Alnutayfi on 02/12/2021.
//

import Foundation
import CoreData
import UIKit

class UserViewModel{
    var users : [User] = [
    User(name: "Abdullah", password: "qwertyuio"),
    User(name: "Aa", password: "aaaaaaaa")
    ]
}

struct User {
    let id = UUID()
    let name : String
    let password : String
}

