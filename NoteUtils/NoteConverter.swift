//
//  NoteConverter.swift
//  TunerHelper
//
//  Created by Andrew Hughes on 10/14/16.
//  Copyright © 2016 Andrew Hughes. All rights reserved.
//

/*
    Handle conversion between various ways of representing a musical note:
        - midi note numbers, range between 21 - 108 on the piano, with A0 = 21 & C8 == 108
        - keyboard numbers, 1 - 88 (often specified with note name, such as middle C as C40, A440 as A37
        - note and octave: C4, A6, etc...
        - frequenty (both equaltemperment and just)
 
    http://www.phy.mtu.edu/~suits/scales.html
    http://www.michaelnorris.info/musictheory/harmonic-series-calculator
    https://en.wikipedia.org/wiki/Harmonic_series_(music)
    https://en.wikipedia.org/wiki/Piano_tuning
 
 */

import Foundation

class NoteConverter {
    
    static let noteToOffset: [String: Int] = [
        "C" : 0,
        "C#": 1,
        "Db": 1,
        "D" : 2,
        "D#": 3,
        "Eb": 3,
        "E" : 4,
        "F" : 5,
        "F#": 6,
        "Gb": 6,
        "G" : 7,
        "G#": 8,
        "Ab": 8,
        "A" : 9,
        "A#": 10,
        "Bb": 10,
        "B" : 11
    ]

    static let offsetToNote: [Int: String] = [
        0: "C",
        1: "C#/Db",
        2: "D",
        3: "D#/Eb",
        4: "E",
        5: "F",
        6: "F#/Gb",
        7: "G",
        8: "G#/Ab",
        9: "A",
        10: "A#/Bb",
        11: "B"
    ]
    
    static let justRatio_25_24:Double = 25/24
    static let justRatio_9_8:Double = 9/8
    static let justRatio_6_5:Double = 6/5
    static let justRatio_5_4:Double = 5_4
    static let justRatio_4_3:Double = 4/3
    static let justRatio_45_32:Double = 45/32
    static let justRatio_3_2:Double = 3/2
    static let justRatio_8_5:Double = 8/5
    static let justRatio_5_3:Double = 5/3
    static let justRatio_9_5:Double = 9/5
    static let justRatio_15_8:Double = 15_8

    static let justScaleRatios: [Int: Double] = [
        0: 1.0,
        1: justRatio_25_24,
        2: justRatio_9_8,
        3: justRatio_6_5,
        4: justRatio_5_4,
        5: justRatio_4_3,
        6: justRatio_45_32,
        7: justRatio_3_2,
        8: justRatio_8_5,
        9: justRatio_5_3,
        10: justRatio_9_5,
        11: justRatio_15_8
    ]
    
    // Note and octave (C3) to midi note number (21-108)
    static func noteAndOctaveToMidiNoteNumber(note:String, octave:Int) -> Int {
        return octave * 12 + 12 + noteToOffset[note]!
    }
    
    // Note and octave (C4) to keyboard number (1-88)
    static func noteAndOctaveToKeyboardNumber(note:String, octave:Int) -> Int {
        let midiNoteNumber:Int = noteAndOctaveToMidiNoteNumber(note: note, octave: octave)
        return midiNoteNumberToKeyboardNumber(noteNumber: midiNoteNumber)
    }
    
    // Midi note number to note and octave (C3)
    static func midiNoteNumberToNoteAndOctave(noteNumber:Int) -> String {
        let octave:Int = Int(noteNumber / 12) - 1
        let offest:Int = noteNumber % 12
        let noteChar:String = offsetToNote[offest]!
        return String(format: "%@%d", noteChar, octave)
    }
    
    // Midi note number to (C, 3) as tuple
    static func midiNoteNumberToNoteAndOctaveAsTuple(noteNumber:Int) -> (String, Int) {
        let octaveAndOffset:(Int, Int) = midiNoteNumberToOctaveAndOffset(noteNumber:noteNumber)
        let noteChar:String = offsetToNote[octaveAndOffset.1]!
        return (noteChar, octaveAndOffset.0);
    }
    
    // Midi note number to note and keyboard number (C60)
    static func midiNoteNumberToNoteAndKeyboardNumber(noteNumber:Int) -> String {
        let offest:Int = noteNumber % 12
        let noteChar:String = offsetToNote[offest]!
        return String(format: "%@%d", noteChar, noteNumber - 20)
    }
    
    // Midi note number to note and keyboard number as typle (C, 60)
    static func midiNoteNumberToNoteAndKeyboardNumberAsTuple(noteNumber:Int) -> (String, Int) {
        let offset:Int = Int(noteNumber % 12)
        let noteChar:String = offsetToNote[offset]!
        return (noteChar, midiNoteNumberToKeyboardNumber(noteNumber: noteNumber));
    }
    
    // Midi note number to keyboard number: 21 -> 1, 108 -> 88
    static func midiNoteNumberToKeyboardNumber(noteNumber:Int) -> Int {
        return noteNumber - 20
    }
    
    // Keyboard number to midi note number: 1 -> 21, 88 -> 108
    static func keyboardNumberToMidiNoteNumber(keyboardNumber:Int) -> Int {
        return keyboardNumber + 20
    }
    
    // Keyboard number to midi note number, octave, and note name
    static func keyboardNumberToAll(keyboardNumber:Int) -> Dictionary<String, Any> {
        let midiNoteNumber: Int = keyboardNumberToMidiNoteNumber(keyboardNumber: keyboardNumber)
        return midiNoteNumberToAll(noteNumber: midiNoteNumber)
    }
    
    // Midi note number to keyboard number, octave, and note name
    static func midiNoteNumberToAll(noteNumber:Int) -> Dictionary<String, Any> {
        
        let octaveAndOffset:(Int, Int) = midiNoteNumberToOctaveAndOffset(noteNumber:noteNumber)
        let noteChar:String = offsetToNote[octaveAndOffset.1]!
        let keyboardNoteNumber = midiNoteNumberToKeyboardNumber(noteNumber: noteNumber)
        
        return [
            "octave": octaveAndOffset.0,
            "noteName": noteChar,
            "offsetFromC": octaveAndOffset.1,
            "keyboardNoteNumber": keyboardNoteNumber,
            "midiNoteNumber": noteNumber
        ];
    }
    
    static func midiNoteNumberToOctaveAndOffset(noteNumber: Int) -> (Int, Int) {
        let octave:Int = Int(noteNumber / 12) - 1
        let offset:Int = noteNumber % 12
        return (octave, offset)
    }
    
    static func keyboardNumberToOctaveAndOffset(keyboardNumber:Int) -> (Int, Int) {
        let midiNoteNumber:Int = keyboardNumberToMidiNoteNumber(keyboardNumber: keyboardNumber)
        return midiNoteNumberToOctaveAndOffset(noteNumber: midiNoteNumber)
    }
    
    // Pre calculate the twelth root of 2, or 2 ^ (1/12) ~ 1.059463
    static let ratioEqualTemperment12Tone:Double = pow(2.0, 1.0/12.0)
    
    // Reference pitch is A 440
    static let referencePitch_Frequency:Double = 440.0
    
    // A 440 is keyboard number 49
    static let referencePitch_KeyboardNumber:Double = 49.0

    // Equal temperment frequency hertz for keyboard number
    static func pitchForKeyboardNumber_EqualTemperment(keyboardNumber:Int) -> Double {
        let pitchHz:Double = referencePitch_Frequency * pow(ratioEqualTemperment12Tone, Double(keyboardNumber) - referencePitch_KeyboardNumber)
        return pitchHz
    }
    
    // Octaves 0-8
    static func baseFrequencyForOctave(octave:Int) -> Double {
        return (27.5 * pow(2.0, Double(octave)))
    }
    
    /*
    static func pitchForMidiNoteNumber_Just(noteNumber:Int) -> Double {
        return pitchForKeyboardNumber_Just(keyboardNumber: midiNoteNumberToKeyboardNumber(noteNumber: noteNumber))
    }
    
    static func pitchForKeyboardNumber_Just(keyboardNumber:Int) -> Double {

        let (octave, offset) = keyboardNumberToOctaveAndOffset(keyboardNumber: keyboardNumber)
        
        let basePitch:Double = baseFrequencyForOctave(octave: octave)
        
        let ratio:Double = justScaleRatios[offset]!
        
        let pitchHz:Double = basePitch * ratio
        
        return pitchHz
    }
    */
    
}
