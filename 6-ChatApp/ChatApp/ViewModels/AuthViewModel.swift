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
    
    static func getLoggedInUserPhone() -> String {
        return Auth.auth().currentUser?.phoneNumber ?? ""
    }

    static func logout() {
        // catch and ignore error if one occurs
        try? Auth.auth().signOut()
    }
    
    static func sendPhoneNumber(phone: String, completion: @escaping (Error?) -> Void) {        
        // Send the phone number to Firebase Auth
        PhoneAuthProvider.provider().verifyPhoneNumber(phone,
                                                       uiDelegate: nil)
        { verificationId, error in
            
            if error == nil {
                // Got the verification id
                UserDefaults.standard.set(verificationId, forKey: "authVerificationID")
            }
            
            DispatchQueue.main.async {
                // Notify the UI
                completion(error)
            }
            
        }
    }
    
    static func verifyCode(code: String, completion: @escaping (Error?) -> Void) {
        
        // Get the verification id from local storage
        let verificationId = UserDefaults.standard.string(forKey: "authVerificationID") ?? ""
        
        // Send the code and the verification id to Firebase
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationId,
          verificationCode: code
        )
        
        // Sign in the user
        Auth.auth().signIn(with: credential) { authResult, error in
            
            DispatchQueue.main.async {
                // Notify the UI
                completion(error)
            }
        }
    }
    
}
