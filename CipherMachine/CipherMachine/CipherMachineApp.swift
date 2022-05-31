//
//  CipherMachineApp.swift
//  CipherMachine
//
//  Created by Spencer Hurd on 5/31/22.
//

import SwiftUI

@main
struct CipherMachineApp: App {
    
    @StateObject var cipherVM = CipherViewModel()
    
    var body: some Scene {
        WindowGroup {
            CipherView()
                .environmentObject(cipherVM)
        }
    }
}
