//
//  MyErrors.swift
//  TakePicture
//
//  Created by Abdullah Alnutayfi on 04/12/2021.
//

import Foundation

enum MyErrors : String, Error{
    case passwoerdFilestLetter = "The password must start with a letter"
    case maxLength = "The paaasword max length must be less than 20 charachters."
    case minLength = "The password min length must be 8 charachters"
}
