//
//  ContentView.swift
//  FocusStateBootCamp
//
//  Created by Leone on 2/12/22.
//

import SwiftUI

struct ContentView: View {
    
    // Case that dictates, which field to place in focus
    // Made hashable so it can be used with the FocusedState
    enum OnboardingField: Hashable {
        case username
        case password
    }
    
    // MARK: - Username Properties
    // Boolean equal to whether/ not the text field is clicked
    @FocusState private var usernameInFocus: Bool
    @State var username: String = ""
    
    // MARK: - Password Properties
    @FocusState private var passwordInFocus: Bool
    @State var password: String = ""
    
    // Tracks the field in focus
    @FocusState private var fieldInFocus: OnboardingField?  // Optional, by default, no field is in focus
    
    var body: some View {
        VStack(spacing: 30) {
            
            // MARK: - Username Field
            TextField("Add your name here...", text: $username)
                .focused($fieldInFocus, equals: .username)
//                .focused($usernameInFocus)
                .padding(.leading) // Pushes text inwards towards center
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
                .onSubmit {
                    // On submit, make the password show up
                    usernameInFocus = false
                    passwordInFocus = true
                }
            
            // MARK: - Password Field
            
            SecureField("Choose a password...", text: $password)
                .focused($fieldInFocus, equals: .password)
//                .focused($passwordInFocus)
                .padding(.leading) // Pushes text inwards towards center
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(Color.gray.brightness(0.3))
                .cornerRadius(10)
            
            // MARK: Sign up Button
            Button("Sign up 🚀") {
                // Declare variables to track if the username and password have values
                let usernameIsValid = !username.isEmpty // if the username is not empty
                let passwordIsValid = !password.isEmpty // if password is not empty
                
                // Make sure both are valid
                if usernameIsValid && passwordIsValid {
                    print("User signed up!")
                }
                else if usernameIsValid {
                    // Else if only the username is valid, then make the password in focus
//                    usernameInFocus = false
//                    passwordInFocus = true
                    fieldInFocus = .password
                
                }
                // Else the user did not even fill out any fields
                else {
//                    usernameInFocus = true
//                    passwordInFocus = false
                    // Make username field in focus
                    fieldInFocus = .username
                }

            }
            
//            Button("TOGGLE IN FOCUS STATE") {
//                usernameInFocus.toggle()
//            }
            
        }
        .padding(40)
        .onAppear {
            // As soon as the View loads, wait a tenth of a second, then toggle the userNameInFocus
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                usernameInFocus.toggle()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
