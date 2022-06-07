//
//  CipherViewModel.swift
//  CipherMachine
//
//  Created by Spencer Hurd on 5/31/22.
//

import Foundation

class CipherViewModel: ObservableObject {
    
    @Published var userKey = ""
    @Published var messageToCode = ""
    
    @Published var decryptKey = ""
    @Published var messageToDecode = ""
    
    @Published var prohibitedCharacterForKey = "01234567890-=!@#$%^&*()_+[]\\{}|;\':\",./<>?`~"
    
    var letterNumberDictionary = [
        // ----------------------------LOWERCASE----------------------------------------
        "a": 1,     "b": 2,     "c": 3,     "d": 4,     "e": 5,     "f": 6,     "g": 7,
        "h": 8,     "i": 9,     "j": 10,    "k": 11,    "l": 12,    "m": 13,    "n": 14,
        "o": 15,    "p": 16,    "q": 17,    "r": 18,    "s": 19,    "t": 20,    "u": 21,
        "v": 22,    "w": 23,    "x": 24,    "y": 25,    "z": 26,
        // ----------------------------UPPERCASE----------------------------------------
        "A": 27,    "B": 28,    "C": 29,    "D": 30,    "E": 31,    "F": 32,    "G": 33,
        "H": 34,    "I": 35,    "J": 36,    "K": 37,    "L": 38,    "M": 39,    "N": 40,
        "O": 41,    "P": 42,    "Q": 43,    "R": 44,    "S": 45,    "T": 46,    "U": 47,
        "V": 48,    "W": 49,    "X": 50,    "Y": 51,    "Z": 52,
        // -----------------------------NUMBERS-----------------------------------------
        "0": 53,    "1": 54,    "2": 55,    "3": 56,    "4": 57,    "5": 58,    "6": 59,
        "7": 60,    "8": 61,    "9": 62,
        // -----------------------------SYMBOLS-----------------------------------------
        "!": 63,    "@": 64,    "#": 65,    "$": 66,    "%": 67,    "^": 68,    "&": 69,
        "*": 70,    "(": 71,    ")": 72,    "-": 73,    "_": 74,    "+": 75,    "=": 76,
        "[": 77,    "]": 78,    "\\": 79,   "|": 80,    ":": 81,    ";": 82,    "\'": 83,
        "\"": 84,   ",": 85,    ".": 86,    "?": 87,    "/": 88,    "<": 89,    ">": 90,
        "`": 91,    "~": 92,    " ": 93,    "’": 94
    ]
    
    var letterArray = [
        "0",
        // ----------------------------LOWERCASE----------------------------------------
        "a",    "b",    "c",    "d",    "e",    "f",    "g",
        "h",    "i",    "j",    "k",    "l",    "m",    "n",
        "o",    "p",    "q",    "r",    "s",    "t",    "u",
        "v",    "w",    "x",    "y",    "z",
        // ----------------------------UPPERCASE----------------------------------------
        "A",    "B",    "C",    "D",    "E",    "F",    "G",
        "H",    "I",    "J",    "K",    "L",    "M",    "N",
        "O",    "P",    "Q",    "R",    "S",    "T",    "U",
        "V",    "W",    "X",    "Y",    "Z",
        // -----------------------------NUMBERS-----------------------------------------
        "0",    "1",    "2",    "3",    "4",    "5",    "6",
        "7",    "8",    "9",
        // -----------------------------SYMBOLS-----------------------------------------
        "!",    "@",    "#",    "$",    "%",    "^",    "&",
        "*",    "(",    ")",    "-",    "_",    "+",    "=",
        "[",    "]",    "\\",   "|",    ":",    ";",    "\'",
        "\"",   ",",    ".",    "?",    "/",    "<",    ">",
        "`",    "~",    " ",    "’"
    ]
    
    func convertKeyToNumber(keyString: String) -> Int {
        var numericValueOfKey = 0
        var arrayOfCharValues: [Int] = []
        for char in keyString {
            let numberValueOfChar = letterNumberDictionary[String(char)]!
            arrayOfCharValues.append(numberValueOfChar)
        }
        for value in arrayOfCharValues {
            numericValueOfKey += value
        }
        return numericValueOfKey
    }
    
    func encryptMessage(userMessage: String, keyNumber: Int) -> String {
        var codedMessage = ""
        for char in userMessage {
            let currentCharacterPosition = letterNumberDictionary[String(char)]!
            var newCharacterPosition = currentCharacterPosition + keyNumber
            while (newCharacterPosition >= letterNumberDictionary.count) {
                newCharacterPosition -= letterNumberDictionary.count
            }
            let codedCharacter = letterArray[newCharacterPosition]
            codedMessage.append(codedCharacter)
        }
        return codedMessage
    }
    
    // UNICODE Example:
    //      var example = Int(UnicodeScalar("A").value)
    
    func decryptMessage(encryptedMessage: String, keyNumber: Int) -> String {
        var decodedMessage = ""
        print("keyNumber = \(keyNumber)")
        for char in encryptedMessage {
            let shiftedCharacterPosition = letterNumberDictionary[String(char)]!
            var actualCharacterPosition = shiftedCharacterPosition - keyNumber
            while (actualCharacterPosition >= letterNumberDictionary.count) {
                actualCharacterPosition -= letterNumberDictionary.count
            }
            while (actualCharacterPosition < 0) {
                actualCharacterPosition += letterNumberDictionary.count
            }
            let decodedCharacter = letterArray[actualCharacterPosition]
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
