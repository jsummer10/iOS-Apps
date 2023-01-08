//
//  VerificationView.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/1/23.
//

import SwiftUI

struct VerificationView: View {
    
    @Binding var currentStep: OnboardingStep
    @Binding var isOnboarding: Bool
    @State var verificationCode = ""
    
    var body: some View {
        VStack {
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter the 6-digit verification code we sent to your device.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            ZStack {
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("e.g. 123456",
                              text: $verificationCode)
                    .font(Font.bodyParagraph)
                    
                    Spacer()
                    
                    Button {
                        // clear text field
                        verificationCode = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                }.padding()
            }.padding(.top, 34)
            
            Spacer()
            
            Button {
                // send the verification code to Firebase
                AuthViewModel.verifyCode(code: verificationCode) { error in
                    if error == nil {
                        // check if user has a profile
                        DatabaseService().checkUserProfile { exists in
                            if exists {
                                // end onboarding
                                isOnboarding = false
                            } else {
                                // profile creation
                                currentStep = .profile
                            }
                        }
                    } else {
                        // TODO: Display error
                    }
                }
            } label: {
                Text("Next")
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
        }.padding(.horizontal)
    }
}
