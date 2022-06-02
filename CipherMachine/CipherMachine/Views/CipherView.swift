//
//  ContentView.swift
//  CipherMachine
//
//  Created by Spencer Hurd on 5/31/22.
//

import SwiftUI

struct CipherView: View {
    
    @EnvironmentObject var vm: CipherViewModel
    
    @State var encryptedMessage = ""
    @State var decryptedMessage = ""
    
    var body: some View {
        ZStack {
            VStack {
                titleSection
                Divider()
                encryptSection
                Divider()
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
            TextField("Enter a word (no spaces, numbers or symbols)", text: $vm.userKey)
                .onChange(of: vm.userKey) { newValue in
                    for char in vm.prohibitedCharacterForKey {
                        if (newValue.contains(char)) {
                            vm.userKey = ""
                        }
                    }
                }
                .padding()
                .background(.gray.opacity(0.1))
            Text("Enter the message to encrypt below:")
            TextEditor(text: $vm.messageToCode)
                .padding()
                .background(.gray.opacity(0.1))
            Button(action: {
                encryptedMessage = vm.encryptMessage(
                    userMessage: $vm.messageToCode.wrappedValue,
                    keyNumber: vm.convertKeyToNumber(keyString: $vm.userKey.wrappedValue)
                )
            }, label: {
                Text("Encrypt My Message")
            })
            Text(encryptedMessage)
        }
    }
    
    var decryptSection: some View {
        VStack {
            Text("DECRYPT:")
            TextField("Enter the key (without spaces)", text: $vm.decryptKey)
                .padding()
                .background(.gray.opacity(0.1))
            Text("Enter the message to decrypt below:")
            TextEditor(text: $vm.messageToDecode)
                .padding()
                .background(.gray.opacity(0.1))
            Button(action: {
                decryptedMessage = vm.decryptMessage(
                    encryptedMessage: $vm.messageToDecode.wrappedValue,
                    keyNumber: vm.convertKeyToNumber(keyString: $vm.userKey.wrappedValue)
                )
            }, label: {
                Text("Decrypt My Message")
            })
            Text(decryptedMessage)
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CipherView()
            .environmentObject(CipherViewModel())
    }
}
