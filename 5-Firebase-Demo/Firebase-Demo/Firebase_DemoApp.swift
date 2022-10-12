//
//  Firebase_DemoApp.swift
//  Firebase-Demo
//
//  Created by Jacob Summerville on 10/12/22.
//

import Firebase
import SwiftUI

@main
struct Firebase_DemoApp: App {
    
    init() {
        FirebaseApp.configure()
        //makeReservation()
        //updateReservation()
        //deleteReservation()
        //errorHandling()
        //readReservation()
        //listenForChanges()
        queryData()
    }
    
    func makeReservation() {
        let db = Firestore.firestore()
        
        // Access the reservations collection
        let reservations = db.collection("reservations")
        
        // Create a document with a given id
        reservations.document("doc123").setData([
            "name"   : "Alex",
            "people" : 4
        ])
        
        // Create a document with a unique id
        reservations.document().setData([
            "name"   : "James",
            "people" : 2
        ])
        
        // Create a document with given data
        reservations.addDocument(data: [
            "name"   : "Pat",
            "people" : 5
        ])
        
        // Documents can be assigned to variables to work with them in the future
    }
    
    func updateReservation() {
        let db = Firestore.firestore()
        
        // Access the reservations collection
        let reservations = db.collection("reservations")
        
        // Access the specific document to update
        let updateDoc = reservations.document("doc123")
        
        // option 1: merge - just changes people field
        updateDoc.updateData([
            "people" : 7
        ])
        
        // option 2: overwrite - removes name field
        //updateDoc.setData([
        //    "people" : 7
        //])
    }
    
    func deleteReservation() {
        let db = Firestore.firestore()
        
        // Access the reservations collection
        let reservations = db.collection("reservations")
        
        // Create document to delete
        let delDoc = reservations.addDocument(data: [
            "name"   : "Delete Me",
            "people" : 9
        ])
        
        // Delete field from document
        delDoc.updateData(["people": FieldValue.delete()])
        
        // Delete the entire document
        delDoc.delete()
    }
    
    func errorHandling() {
        let db = Firestore.firestore()
        
        // Access the reservations collection
        let reservations = db.collection("reservations")
        
        reservations.addDocument(data: [:]) { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                return
            }
        }
    }
    
    func readReservation() {
        let db = Firestore.firestore()
        
        // Access the reservations collection
        let reservations = db.collection("reservations")
        
        // Get document
        let document = reservations.document("doc123")
        
        // Get document info from db
        document.getDocument { (docSnapshot, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let docSnapshot = docSnapshot {
                print(docSnapshot.data() ?? "")
                print(docSnapshot.documentID)
            } else {
                print("No data was returned")
            }
        }
        
        // Get all documents from a collection
        reservations.getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let querySnapshot = querySnapshot {
                for doc in querySnapshot.documents {
                    print(doc.documentID)
                }
            } else {
                print("No data was returned")
            }
        }
    }
    
    func listenForChanges() {
        let db = Firestore.firestore()
        
        // Access the reservations collection
        let reservations = db.collection("reservations")
        
        // Get document
        let document = reservations.document("doc123")
        
        let listener = document.addSnapshotListener { docSnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let docSnapshot = docSnapshot {
                // Print data everytime a change is made to the document
                print(docSnapshot.data() ?? "")
            } else {
                print("No data was returned")
            }
        }
        
        // Remove the snapshot listener
        // listener.remove()
    }
    
    func queryData () {
        let db = Firestore.firestore()
        
        // Access the reservations collection
        let reservations = db.collection("reservations")
        
        // Query the db
        let query = reservations.whereField("name", in: ["Dave", "James"])
        
        query.getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let querySnapshot = querySnapshot {
                for doc in querySnapshot.documents {
                    print(doc.data())
                }
            } else {
                print("No data was returned")
            }
        }
        
        // Compound queries
        let compoundQuery = reservations
            .whereField("name", in: ["Dave", "James"])
            .whereField("people", isLessThan: 5)
        
        compoundQuery.getDocuments { querySnapshot, error in
            if let error = error {
                print(error.localizedDescription)
            } else if let querySnapshot = querySnapshot {
                for doc in querySnapshot.documents {
                    print(doc.data())
                }
            } else {
                print("No data was returned")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
