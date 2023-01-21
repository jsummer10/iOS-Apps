//
//  PhoneNumberView.swift
//  ChatApp
//
//  Created by Jacob Summerville on 1/1/23.
//

import SwiftUI
import Combine

struct PhoneNumberView: View {
    
    @Binding var currentStep: OnboardingStep
    @State var phoneNumber = ""
    @State var isButtonDisabled = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Text("Verification")
                .font(Font.titleText)
                .padding(.top, 52)
            
            Text("Enter your mobile number below. We'll send you a verification code after.")
                .font(Font.bodyParagraph)
                .padding(.top, 12)
            
            ZStack {
                Rectangle()
                    .frame(height: 56)
                    .foregroundColor(Color("input"))
                
                HStack {
                    TextField("e.g. +1 613 515 0123", text: $phoneNumber)
                        .font(Font.bodyParagraph)
                        .keyboardType(.numberPad)
                        .onReceive(Just(phoneNumber)) { _ in
                            TextUtil.applyPatternOnNumbers(&phoneNumber,
                                                             pattern: "+# (###) ###-####",
                                                             replacementCharacter: "#")
                        }
                    
                    Spacer()
                    
                    Button { 
                        // clear text field
                        phoneNumber = ""
                    } label: {
                        Image(systemName: "multiply.circle.fill")
                    }
                    .frame(width: 19, height: 19)
                    .tint(Color("icons-input"))
                }.padding()
            }.padding(.top, 34)
            
            Spacer()
            
            Button {
                // disable the button from multiple taps
                isButtonDisabled = true
                
                // verify user
                AuthViewModel.sendPhoneNumber(phone: phoneNumber) { error in
                    if error == nil {
                        // move to next step
                        currentStep = .verification
                    } else {
                        // display error message
                        showAlert = true
                    }
                }
                
                // re-enable button
                isButtonDisabled = false
                
            } label: {
                HStack {
                    Text("Next")
                    
                    if isButtonDisabled {
                        ProgressView()
                            .padding(.leading, 2)
                    }
                }
            }
            .buttonStyle(OnboardingButtonStyle())
            .padding(.bottom, 87)
            .disabled(isButtonDisabled)
        }
        .padding(.horizontal)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Account Verification Error"),
                message: Text("There was an error trying to verify your account.")
            )
        }
    }
}
