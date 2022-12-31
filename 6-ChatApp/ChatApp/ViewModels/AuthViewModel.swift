//
//  AuthViewModel.swift
//  ChatApp
//
//  Created by Jacob Summerville on 12/31/22.
//

import Foundation
import FirebaseAuth

class AuthViewModel {
    
    static func isUserLoggedIn() -> Bool {
        // returns whether or not a user is logged in
        return Auth.auth().currentUser != nil
    }
    
    static func getLoggedInUserId() -> String {
        // returns current user's ID or an empty string if
        // an error occurs
        return Auth.auth().currentUser?.uid ?? ""
    }
    
    static func logout() {
        // catch and ignore error if one occurs
        try? Auth.auth().signOut()
    }
    
}
