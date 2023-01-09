//
//  DatabaseService.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/1/23.
//

import Foundation
import Contacts
import Firebase
import FirebaseStorage
import UIKit

class DatabaseService {
    
    func getPlatformUsers(localContacts: [CNContact], completion: @escaping ([User]) -> Void) {
        
        var platformUsers = [User]()
        
        // construct an array of string phone numbers
        var lookupPhoneNumbers = localContacts.map { contact in
            // turn the contact into a phone number
            return TextUtil.sanitizePhoneNumber(contact.phoneNumbers.first?.value.stringValue ?? "")
        }
        
        // verify lookup numbers
        guard lookupPhoneNumbers.count > 0 else {
            completion(platformUsers)
            return
        }
        
        let db = Firestore.firestore()
        
        // iterates through 10 phone numbers at a time since
        // only 10 items can be queried at a time
        while !lookupPhoneNumbers.isEmpty {
            let tenPhoneNumbers = Array(lookupPhoneNumbers.prefix(10))
            lookupPhoneNumbers = Array(lookupPhoneNumbers.dropFirst(10))
            
            let query = db.collection("users").whereField("phone", in: tenPhoneNumbers)
            
            query.getDocuments { snapshot, error in
                if error == nil && snapshot != nil {
                    
                    // create a user for each doc that was fetched
                    for doc in snapshot!.documents {
                        if let user = try? doc.data(as: User.self){
                            // add user to platform users
                            platformUsers.append(user)
                        }
                    }
                    
                    // check if we have anymore phone numbers
                    if lookupPhoneNumbers.isEmpty {
                        completion(platformUsers)
                    }
                    
                }
            }
        }
    }
    
    func setUserProfile(firstName: String, lastName: String, image: UIImage?, completion: @escaping (Bool) -> Void) {
        
        // ensure user is logged in
        guard AuthViewModel.isUserLoggedIn() != false else {
            // user is not logged in
            return
        }
        
        // get user's phone number
        let userPhone = TextUtil.sanitizePhoneNumber(AuthViewModel.getLoggedInUserPhone())
        
        let db = Firestore.firestore()
        
        // add new user info
        let doc = db.collection("users").document(AuthViewModel.getLoggedInUserId())
        doc.setData(["firstname" : firstName,
                     "lastName": lastName,
                     "phone": userPhone])
        
        // Check if an image is passed through
        if let image = image {
            
            // Create storage reference
            let storageRef = Storage.storage().reference()
            
            // Turn our image into data
            let imageData = image.jpegData(compressionQuality: 0.8)
            
            // Check that we were able to convert it to data
            guard imageData != nil else {
                return
            }
            
            // Specify the file path and name
            let path = "images/\(UUID().uuidString).jpg"
            let fileRef = storageRef.child(path)
            
            fileRef.putData(imageData!, metadata: nil) { meta, error in
                
                if error == nil && meta != nil {
                    // Get full url to image
                    fileRef.downloadURL { url, error in
                        
                        // Check for errors
                        if url != nil && error == nil {
                            
                            // Set that image path to the profile
                            doc.setData(["photo": url!.absoluteString], merge: true) { error in
                                
                                if error == nil {
                                    // Success, notify caller
                                    completion(true)
                                }
                            }
                        } else {
                            // Wasn't successful in getting download url for photo
                            completion(false)
                        }
                    }
                } else {
                    // Upload wasn't successful, notify caller
                    completion(false)
                }
            }
            
        } else {
            // No image was set
            completion(true)
        }
    }
    
    func checkUserProfile(completion: @escaping (Bool) -> Void) {
        
        // Check that the user is logged
        guard AuthViewModel.isUserLoggedIn() != false else {
            return
        }
        
        // Create firebase ref
        let db = Firestore.firestore()
        
        db.collection("users").document(AuthViewModel.getLoggedInUserId()).getDocument { snapshot, error in
            
            // TODO: Keep the users profile data
            if snapshot != nil && error == nil {
                
                // Notify that profile exists
                completion(snapshot!.exists)
            } else {
                // TODO: Look into using Result type to indicate failure vs profile exists
                completion(false)
            }
            
        }
        
    }
}
