//
//  ContentView.swift
//  CipherMachine
//
//  Created by Spencer Hurd on 5/31/22.
//

import SwiftUI

struct CipherView: View {
    
    @EnvironmentObject var vm: CipherViewModel
    
    var body: some View {
        ZStack {
            VStack {
                titleSection
                encryptSection
                decryptSection
            }
            .padding()
        }
    }
    
}

extension CipherView {
    
    var titleSection: some View {
        Text("Cipher Machine")
            .font(.title)
    }
    
    var encryptSection: some View {
        VStack {
            Text("ENCRYPT:")
            TextField("key", text: $vm.userKey)
                .onChange(of: vm.userKey) { newValue in
                    if (vm.userKey.count > 0) {
                        vm.userKeyIsEntered = true
                    }
                }
            TextEditor(text: $vm.userMessage)
                .foregroundColor(.secondary.opacity(0.5))
                .onChange(of: vm.userMessage) { newValue in
                    if (vm.userMessage.count > 0 && vm.userMessage != "Message") {
                        vm.userKeyIsEntered = true
                    }
                }
            // TODO: Insert encrypted message here
            if (vm.userKeyIsEntered && vm.userMessageIsEntered) {
                Text(vm.encryptMessage(userMessage: vm.userMessage, keyNumber: vm.convertKeyToNumber(keyString: vm.userKey)))
            }
        }
    }
    
    var decryptSection: some View {
        VStack {
            Text("DECRYPT:")
            TextField("key", text: $vm.decryptKey)
            TextEditor(text: $vm.codedMessage)
                .foregroundColor(.secondary.opacity(0.5))
            // TODO: Insert decrypted message here
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CipherView()
            .environmentObject(CipherViewModel())
    }
}
