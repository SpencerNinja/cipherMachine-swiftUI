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
            Color.black
                .ignoresSafeArea()
            
            contentSection
        }
    }
    
}

extension CipherView {
    
    var contentSection: some View {
        VStack {
            titleSection
            Divider()
                .background()
            encryptSection
            Divider()
                .background()
            decryptSection
        }
        .padding()
    }
    
    var titleSection: some View {
        Text("Cipher Machine")
            .font(.title)
            .foregroundColor(.gray)
    }
    
    var encryptSection: some View {
        VStack(spacing: 0) {
            Text("ENCRYPT:")
                .foregroundColor(.gray)
            TextField("Enter a word (no spaces, numbers or symbols)", text: $vm.userKey)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(.mint))
                .autocapitalization(.none)
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
                .foregroundColor(.gray)
            TextEditor(text: $vm.messageToCode)
                .cornerRadius(10)
                .autocapitalization(.none)
                .padding()
                .background(.gray.opacity(0.1))
            Button(action: {
                encryptedMessage = vm.encryptMessage(
                    userMessage: $vm.messageToCode.wrappedValue,
                    keyNumber: vm.convertKeyToNumber(keyString: $vm.userKey.wrappedValue)
                )
            }, label: {
                Text("Encrypt My Message")
                    .foregroundColor(.mint)
                    .padding()
                    .border(.mint)
                    .cornerRadius(10)
            })
            ScrollView {
                Text(encryptedMessage)
                    .foregroundColor(.teal)
            }
        }
    }
    
    var decryptSection: some View {
        VStack(spacing: 0) {
            Text("DECRYPT:")
                .foregroundColor(.gray)
            TextField("Enter the key (without spaces)", text: $vm.decryptKey)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(.mint))
                .autocapitalization(.none)
                .padding()
                .background(.gray.opacity(0.1))
            Text("Enter the message to decrypt below:")
                .foregroundColor(.gray)
            TextEditor(text: $vm.messageToDecode)
                .cornerRadius(10)
                .autocapitalization(.none)
                .onChange(of: vm.messageToDecode) { newValue in
                    if (newValue.contains("”")) {
                        vm.messageToDecode.removeLast()
                        vm.messageToDecode.append("\"")
                    } else if newValue.contains("’") {
                        vm.messageToDecode.removeLast()
                        vm.messageToDecode.append("\'")
                    }
                }
                .padding()
                .background(.gray.opacity(0.1))
            Button(action: {
                decryptedMessage = vm.decryptMessage(
                    encryptedMessage: $vm.messageToDecode.wrappedValue,
                    keyNumber: vm.convertKeyToNumber(keyString: $vm.userKey.wrappedValue)
                )
            }, label: {
                Text("Decrypt My Message")
                    .foregroundColor(.mint)
                    .padding()
                    .border(.mint)
                    .cornerRadius(10)
            })
            ScrollView {
                Text(decryptedMessage)
                    .foregroundColor(.red)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CipherView()
            .environmentObject(CipherViewModel())
    }
}
