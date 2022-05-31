//
//  ContentView.swift
//  CipherMachine
//
//  Created by Spencer Hurd on 5/31/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 
 ENCRYPT PROCESS:
 1. User types in key (string) to code message with
 2. Computer translates key into a number
 3. User types in the message they want to code
 4. The computer encrypts the message (for each character in user message)
    a. If char in user message is not a space character
        i. Add constanant letter key number of places to the right to coded array
    b. If space character
        i. Add a vowel character
    c. If message has finished coding, display coded message
 
 DECRYPT PROCESS:
 1. User types in key (string) that message was coded with
 2. User types in coded message
 3. Computer converts key to the numeric value
 4. Computer decodes message (for each character in coded message)
    a. If character is a constanant
        i.  find character key number places to the left
        ii. add character to decoded array
    b. If character is a vowel
        i. add a space character to the coded message
 
 
 */
