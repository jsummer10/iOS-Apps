//
//  User.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/1/23.
//

import Foundation
import FirebaseFirestoreSwift

struct User : Codable, Identifiable {
    @DocumentID var id : String?
    
    var firstname   : String?
    var lastname    : String?
    var phone       : String?
    var photo       : String?
    var isactive    : Bool = true
}
