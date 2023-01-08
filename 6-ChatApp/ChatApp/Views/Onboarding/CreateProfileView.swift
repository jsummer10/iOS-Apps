//
//  ProfileView.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/1/23.
//

import SwiftUI

struct CreateProfileView: View {
    
    @Binding var currentStep: OnboardingStep
    
    // user info state variables
    @State var firstName = ""
    @State var lastName  = ""
    
    // image picker state variables
    @State var selectedImage: UIImage?
    @State var isPickerShowing = false
    @State var source: UIImagePickerController.SourceType = .photoLibrary
    @State var isSourceMenuShowing = false
    
    @State var isSaveButtonDisabled = false
    
    var body: some View {
        VStack {
            Text("Setup your Profile")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Just a few more details to get started")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            Spacer()
            
            Button {
                // display profile image picker
                isSourceMenuShowing = true
            } label: {
                ZStack {
                    if selectedImage != nil {
                        Image(uiImage: selectedImage!)
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                    } else {
                        Circle()
                            .foregroundColor(Color.white)
                        
                        Image(systemName: "camera.fill")
                            .tint(Color("icons-input"))
                    }
                    
                    Circle()
                        .stroke(Color("create-profile-border"), lineWidth: 2)
                }.frame(width: 134, height: 134)
            }
            
            Spacer()
            
            TextField("First Name", text: $firstName)
                .textFieldStyle(CreateProfileTextFieldStyle())
            
            TextField("Last Name", text: $lastName)
                .textFieldStyle(CreateProfileTextFieldStyle())
            
            Spacer()
            
            Button {
                // Prevent double taps
                isSaveButtonDisabled = true
                
                DatabaseService().setUserProfile(firstName: firstName,
                                                 lastName: lastName,
                                                 image: selectedImage) { isSuccess in
                    if isSuccess {
                        currentStep = .contacts
                    }
                    else {
                        // TODO: Show error message to the user
                    }
                    
                    isSaveButtonDisabled = false
                }
            } label: {
                Text(isSaveButtonDisabled ? "Saving..." : "Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            .disabled(isSaveButtonDisabled)
        }
        .padding(.horizontal)
        .confirmationDialog("From where?", isPresented: $isSourceMenuShowing, actions: {
            
            Button {
                source = .photoLibrary
                isPickerShowing = true
            } label: {
                Text("Photo Library")
            }
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                Button {
                    source = .camera
                    isPickerShowing = true
                } label: {
                    Text("Take Photo")
                }
            }
        })
        .sheet(isPresented: $isPickerShowing) {
            // display image picker
            ImagePicker(selectedImage: $selectedImage, isPickerShowing: $isPickerShowing, source: self.source)
            }
    }
}
