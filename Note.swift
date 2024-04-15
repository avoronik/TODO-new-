//
//  Note.swift
//  toDoList2
//
//  Created by Anastasia on 12/04/24.
//

import UIKit

struct Note {
    var title: String
    var image: UIImage
    var group: String
    var isCompleted: Bool = false
    
}

var imageArray: [UIImage] = [ UIImage(systemName: "cart.fill")!,
                              UIImage(systemName: "graduationcap.fill")!,
                              UIImage(systemName: "bag.fill")!,
                              UIImage(systemName: "creditcard.fill")!,
                              UIImage(systemName: "washer.fill")!,
                              UIImage(systemName: "popcorn.fill")!]
var group: [String] = [
                        "Shopping",
                        "Studying",
                        "Work",
                        "Bills",
                        "Housekeeping",
                        "Amusement"
                        ]

