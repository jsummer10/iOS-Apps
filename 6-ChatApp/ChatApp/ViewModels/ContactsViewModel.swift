//
//  ContactsViewModel.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/1/23.
//

import Foundation
import Contacts

class ContactsViewModel : ObservableObject {
    
    @Published var users = [User]()
    private var localContacts = [CNContact]()
    
    func getLocalContacts() {
        
        // perform contact fetch asynchronously
        DispatchQueue.init(label: "getcontacts").async {
            do {
                // ask for permission
                let store = CNContactStore()
                
                // keys to fetch
                let keys = [CNContactPhoneNumbersKey, CNContactGivenNameKey, CNContactFamilyNameKey] as! [CNKeyDescriptor]
                
                // create a fetch request
                let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
                
                // process request
                try store.enumerateContacts(with: fetchRequest, usingBlock: { contact, success in
                    self.localContacts.append(contact)
                })
                
                // extract contacts that use this app
                DatabaseService().getPlatformUsers(localContacts: self.localContacts) { platformUsers in
                    DispatchQueue.main.async {
                        self.users = platformUsers
                    }
                }
                
            } catch {
                
            }
        }
    }
    
}
