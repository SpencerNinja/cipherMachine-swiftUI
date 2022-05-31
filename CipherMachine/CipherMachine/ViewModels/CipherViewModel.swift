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
    @Published var userKeyIsEntered = false
    @Published var userMessageIsEntered = false
    
    @Published var decryptKey = ""
    @Published var codedMessage = "Message"
    @Published var codedKeyIsEntered = false
    @Published var codedMessageIsEntered = false
    
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
        "A": 27,
        "B": 28,
        "C": 29,
        "D": 30,
        "E": 31,
        "F": 32,
        "G": 33,
        "H": 34,
        "I": 35,
        "J": 36,
        "K": 37,
        "L": 38,
        "M": 39,
        "N": 40,
        "O": 41,
        "P": 42,
        "Q": 43,
        "R": 44,
        "S": 45,
        "T": 46,
        "U": 47,
        "V": 48,
        "W": 49,
        "X": 50,
        "Y": 51,
        "Z": 52,
        "0": 53,
        "1": 54,
        "2": 55,
        "3": 56,
        "4": 57,
        "5": 58,
        "6": 59,
        "7": 60,
        "8": 61,
        "9": 62,
        "!": 63,
        "@": 64,
        "#": 65,
        "$": 66,
        "%": 67,
        "^": 68,
        "&": 69,
        "*": 70,
        "(": 71,
        ")": 72,
        "-": 73,
        "_": 74,
        "+": 75,
        "=": 76,
        "[": 77,
        "]": 78,
        "\\": 79,
        "|": 80,
        ":": 81,
        ";": 82,
        "'": 83,
        "\"": 84,
        ",": 85,
        ".": 86,
        "?": 87,
        "/": 88,
        "<": 89,
        ">": 90,
        "`": 91,
        "~": 92
    ]
    
//    let alphabetArray = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    let vowels = ["a", "e", "i", "o", "u"] // excluding y, which is only a vowel sometimes
    let consonants = ["b", "c", "d", "f", "g", "h", "j", "k", "l", "m", "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z"]
    
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
    
    func encryptMessage(userMessage: String, keyNumber: Int) -> String {
        var codedCharacter = ""
        var characterPosition = 0
        var codedMessage = ""
        for char in userMessage {
            for (letter, value) in letterNumberDictionary {
                if (String(char) == letter) {
                    characterPosition = value
                }
            }
            if (char == " ") {
                codedCharacter = vowels.randomElement()!
            } else {
                characterPosition += keyNumber
                codedCharacter = consonants[characterPosition]
            }
            codedMessage.append(codedCharacter)
        }
        return codedMessage
    }
    
    func decryptMessage(encryptedMessage: String, keyNumber: Int) -> String {
        var decodedCharacter = ""
        var characterPosition = 0
        var decodedMessage = ""
        for char in encryptedMessage {
            for (letter, value) in letterNumberDictionary {
                if (String(char) == letter) {
                    characterPosition = value
                }
            }
            if (char == " ") {
                decodedCharacter = vowels.randomElement()!
            } else {
                characterPosition -= keyNumber
                decodedCharacter = consonants[characterPosition]
            }
            decodedMessage.append(decodedCharacter)
        }
        return decodedMessage
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
