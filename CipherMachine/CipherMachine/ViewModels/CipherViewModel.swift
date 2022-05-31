//
//  CipherViewModel.swift
//  CipherMachine
//
//  Created by Spencer Hurd on 5/31/22.
//

import Foundation

class CipherViewModel: ObservableObject {
    
    @Published var userKey = ""
    @Published var userMessage = "Message"
    @Published var decryptKey = ""
    @Published var codedMessage = "Message"
    
    var letterNumberDictionary = [
        "a": 1,
        "b": 2,
        "c": 3,
        "d": 4,
        "e": 5,
        "f": 6,
        "g": 7,
        "h": 8,
        "i": 9,
        "j": 10,
        "k": 11,
        "l": 12,
        "m": 13,
        "n": 14,
        "o": 15,
        "p": 16,
        "q": 17,
        "r": 18,
        "s": 19,
        "t": 20,
        "u": 21,
        "v": 22,
        "w": 23,
        "x": 24,
        "y": 25,
        "z": 26,
    ]
    
    func convertKeyToNumber(keyString: String) -> Int {
        var numericValueOfKey = 0
        for char in keyString {
            for (letter, value) in letterNumberDictionary {
                if (String(char) == letter) {
                    numericValueOfKey += value
                }
            }
        }
        return numericValueOfKey
    }
    
    func convertUserMessage() {
        
    }
    
}
