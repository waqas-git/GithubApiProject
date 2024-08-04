//
//  GFError.swift
//  JulyProject
//
//  Created by waqas ahmed on 25/07/2024.
//

import Foundation
enum GFError: String, Error{
    case invalidUserName    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Server doesn't respond to the application. Please try again."
    case invalidData        = "The Data received from the server is invalid. Please try again."
    case unableToFavourite  = "Unable to load or save favourite data to server "
    case alreadyInFavourite = "This user aleady in favourite list."
}
