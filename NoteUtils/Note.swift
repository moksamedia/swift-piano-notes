//
//  Note.swift
//  NoteUtils
//
//  Created by Andrew Hughes on 10/16/16.
//  Copyright © 2016 Andrew Hughes. All rights reserved.
//

import Foundation


class Note: Equatable, Hashable, CustomStringConvertible, CustomDebugStringConvertible {
    
    var midiNoteNumber:Int!
    var keyboardNumber:Int!
    var octave:Int!
    var offsetFromC:Int!
    var frequencyHz:Double!
    var noteName:String
    
    init(noteMidi:Int) {
        let data = NoteConverter.midiNoteNumberToAll(noteNumber: noteMidi)
        midiNoteNumber = data["midiNoteNumber"] as! Int
        keyboardNumber = data["keyboardNoteNumber"] as! Int
        octave = data["octave"] as! Int
        noteName = data["noteName"] as! String
        offsetFromC = data["offsetFromC"] as! Int
        frequencyHz = NoteConverter.pitchForKeyboardNumber_EqualTemperment(keyboardNumber: keyboardNumber)
    }
    
    init(keyboardNum:Int) {
        let data = NoteConverter.keyboardNumberToAll(keyboardNumber: keyboardNum)
        midiNoteNumber = data["midiNoteNumber"] as! Int
        keyboardNumber = data["keyboardNoteNumber"] as! Int
        octave = data["octave"] as! Int
        noteName = data["noteName"] as! String
        offsetFromC = data["offsetFromC"] as! Int
        frequencyHz = NoteConverter.pitchForKeyboardNumber_EqualTemperment(keyboardNumber: keyboardNumber)
    }
    
    var description:String {
        return String(format:"%@%d", noteName, octave, keyboardNumber, midiNoteNumber, frequencyHz)
    }
    
    var debugDescription:String {
        return String(format:"%@%d, kb = %d, midi = %d, HZ = %f", noteName, octave, keyboardNumber, midiNoteNumber, frequencyHz)
    }
    
    static func ==(left: Note, right: Note) -> Bool {
        return left.midiNoteNumber == right.midiNoteNumber
    }
    
    var hashValue: Int {
        return midiNoteNumber
    }
    
    // By note name and octave
    
    static let A0 = Note(noteMidi:21)
    static let A1 = Note(noteMidi:21+12*1)
    static let A2 = Note(noteMidi:21+12*2)
    static let A3 = Note(noteMidi:21+12*3)
    static let A4 = Note(noteMidi:21+12*4)
    static let A5 = Note(noteMidi:21+12*5)
    static let A6 = Note(noteMidi:21+12*6)
    static let A7 = Note(noteMidi:21+12*7)
    static let A8 = Note(noteMidi:21+12*8)
    
    static let Bb0 = Note(noteMidi:22)
    static let Bb1 = Note(noteMidi:22+12*1)
    static let Bb2 = Note(noteMidi:22+12*2)
    static let Bb3 = Note(noteMidi:22+12*3)
    static let Bb4 = Note(noteMidi:22+12*4)
    static let Bb5 = Note(noteMidi:22+12*5)
    static let Bb6 = Note(noteMidi:22+12*6)
    static let Bb7 = Note(noteMidi:22+12*7)
    static let Bb8 = Note(noteMidi:22+12*8)
    
    static let Asharp0 = Bb0
    static let Asharp1 = Bb1
    static let Asharp2 = Bb2
    static let Asharp3 = Bb3
    static let Asharp4 = Bb4
    static let Asharp5 = Bb5
    static let Asharp6 = Bb6
    static let Asharp7 = Bb7
    static let Asharp8 = Bb8
    
    static let B0 = Note(noteMidi:23)
    static let B1 = Note(noteMidi:23+12*1)
    static let B2 = Note(noteMidi:23+12*2)
    static let B3 = Note(noteMidi:23+12*3)
    static let B4 = Note(noteMidi:23+12*4)
    static let B5 = Note(noteMidi:23+12*5)
    static let B6 = Note(noteMidi:23+12*6)
    static let B7 = Note(noteMidi:23+12*7)
    static let B8 = Note(noteMidi:23+12*8)
    
    static let C0 = Note(noteMidi:12)
    static let C1 = Note(noteMidi:24)
    static let C2 = Note(noteMidi:24+12*1)
    static let C3 = Note(noteMidi:24+12*2)
    static let C4 = Note(noteMidi:24+12*3)
    static let C5 = Note(noteMidi:24+12*4)
    static let C6 = Note(noteMidi:24+12*5)
    static let C7 = Note(noteMidi:24+12*6)
    static let C8 = Note(noteMidi:24+12*7)
    
    static let Csharp1 = Note(noteMidi:25)
    static let Csharp2 = Note(noteMidi:25+12*1)
    static let Csharp3 = Note(noteMidi:25+12*2)
    static let Csharp4 = Note(noteMidi:25+12*3)
    static let Csharp5 = Note(noteMidi:25+12*4)
    static let Csharp6 = Note(noteMidi:25+12*5)
    static let Csharp7 = Note(noteMidi:25+12*6)
    static let Csharp8 = Note(noteMidi:25+12*7)
    
    static let Db1 = Csharp1
    static let Db2 = Csharp2
    static let Db3 = Csharp3
    static let Db4 = Csharp4
    static let Db5 = Csharp5
    static let Db6 = Csharp6
    static let Db7 = Csharp7
    static let Db8 = Csharp8
    
    static let D1 = Note(noteMidi:26)
    static let D2 = Note(noteMidi:26+12*1)
    static let D3 = Note(noteMidi:26+12*2)
    static let D4 = Note(noteMidi:26+12*3)
    static let D5 = Note(noteMidi:26+12*4)
    static let D6 = Note(noteMidi:26+12*5)
    static let D7 = Note(noteMidi:26+12*6)
    static let D8 = Note(noteMidi:26+12*7)
    
    static let Dsharp1 = Note(noteMidi:27)
    static let Dsharp2 = Note(noteMidi:27+12*1)
    static let Dsharp3 = Note(noteMidi:27+12*2)
    static let Dsharp4 = Note(noteMidi:27+12*3)
    static let Dsharp5 = Note(noteMidi:27+12*4)
    static let Dsharp6 = Note(noteMidi:27+12*5)
    static let Dsharp7 = Note(noteMidi:27+12*6)
    static let Dsharp8 = Note(noteMidi:27+12*7)
    
    static let Eb1 = Dsharp1
    static let Eb2 = Dsharp2
    static let Eb3 = Dsharp3
    static let Eb4 = Dsharp4
    static let Eb5 = Dsharp5
    static let Eb6 = Dsharp6
    static let Eb7 = Dsharp7
    static let Eb8 = Dsharp8
    
    static let E1 = Note(noteMidi:28)
    static let E2 = Note(noteMidi:28+12*1)
    static let E3 = Note(noteMidi:28+12*2)
    static let E4 = Note(noteMidi:28+12*3)
    static let E5 = Note(noteMidi:28+12*4)
    static let E6 = Note(noteMidi:28+12*5)
    static let E7 = Note(noteMidi:28+12*6)
    static let E8 = Note(noteMidi:28+12*7)
    
    static let F1 = Note(noteMidi:29)
    static let F2 = Note(noteMidi:29+12*1)
    static let F3 = Note(noteMidi:29+12*2)
    static let F4 = Note(noteMidi:29+12*3)
    static let F5 = Note(noteMidi:29+12*4)
    static let F6 = Note(noteMidi:29+12*5)
    static let F7 = Note(noteMidi:29+12*6)
    static let F8 = Note(noteMidi:29+12*7)
    
    static let Fsharp1 = Note(noteMidi:30)
    static let Fsharp2 = Note(noteMidi:30+12*1)
    static let Fsharp3 = Note(noteMidi:30+12*2)
    static let Fsharp4 = Note(noteMidi:30+12*3)
    static let Fsharp5 = Note(noteMidi:30+12*4)
    static let Fsharp6 = Note(noteMidi:30+12*5)
    static let Fsharp7 = Note(noteMidi:30+12*6)
    static let Fsharp8 = Note(noteMidi:30+12*7)
    
    static let Gb1 = Fsharp1
    static let Gb2 = Fsharp2
    static let Gb3 = Fsharp3
    static let Gb4 = Fsharp4
    static let Gb5 = Fsharp5
    static let Gb6 = Fsharp6
    static let Gb7 = Fsharp7
    static let Gb8 = Fsharp8
    
    static let G1 = Note(noteMidi:31)
    static let G2 = Note(noteMidi:31+12*1)
    static let G3 = Note(noteMidi:31+12*2)
    static let G4 = Note(noteMidi:31+12*3)
    static let G5 = Note(noteMidi:31+12*4)
    static let G6 = Note(noteMidi:31+12*5)
    static let G7 = Note(noteMidi:31+12*6)
    static let G8 = Note(noteMidi:31+12*7)
    
    static let Gsharp1 = Note(noteMidi:32)
    static let Gsharp2 = Note(noteMidi:32+12*1)
    static let Gsharp3 = Note(noteMidi:32+12*2)
    static let Gsharp4 = Note(noteMidi:32+12*3)
    static let Gsharp5 = Note(noteMidi:32+12*4)
    static let Gsharp6 = Note(noteMidi:32+12*5)
    static let Gsharp7 = Note(noteMidi:32+12*6)
    static let Gsharp8 = Note(noteMidi:32+12*7)
    
    static let Ab1 = Gsharp1
    static let Ab2 = Gsharp2
    static let Ab3 = Gsharp3
    static let Ab4 = Gsharp4
    static let Ab5 = Gsharp5
    static let Ab6 = Gsharp6
    static let Ab7 = Gsharp7
    static let Ab8 = Gsharp8
    
    // By keyboard note number
    
    static let key_1 = A0
    static let key_2 = Asharp0
    static let key_3 = B0
    
    static let key_4 = C1
    static let key_5 = Csharp1
    static let key_6 = D1
    static let key_7 = Dsharp1
    static let key_8 = E1
    static let key_9 = F1
    
    static let key_01 = A0
    static let key_02 = Asharp0
    static let key_03 = B0
    
    static let key_04 = C1
    static let key_05 = Csharp1
    static let key_06 = D1
    static let key_07 = Dsharp1
    static let key_08 = E1
    static let key_09 = F1
    static let key_10 = Fsharp1
    static let key_11 = G1
    static let key_12 = Gsharp1
    static let key_13 = A1
    static let key_14 = Asharp1
    static let key_15 = B1
    
    static let key_16 = C2
    static let key_17 = Csharp2
    static let key_18 = D2
    static let key_19 = Dsharp2
    static let key_20 = E2
    static let key_21 = F2
    static let key_22 = Fsharp2
    static let key_23 = G2
    static let key_24 = Gsharp2
    static let key_25 = A2
    static let key_26 = Asharp2
    static let key_27 = B2
    
    static let key_28 = C3
    static let key_29 = Csharp3
    static let key_30 = D3
    static let key_31 = Dsharp3
    static let key_32 = E3
    static let key_33 = F3
    static let key_34 = Fsharp3
    static let key_35 = G3
    static let key_36 = Gsharp3
    static let key_37 = A3
    static let key_38 = Asharp3
    static let key_39 = B3
    
    static let key_40 = C4
    static let key_41 = Csharp4
    static let key_42 = D4
    static let key_43 = Dsharp4
    static let key_44 = E4
    static let key_45 = F4
    static let key_46 = Fsharp4
    static let key_47 = G4
    static let key_48 = Gsharp4
    static let key_49 = A4
    static let key_50 = Asharp4
    static let key_51 = B4
    
    static let key_52 = C5
    static let key_53 = Csharp5
    static let key_54 = D5
    static let key_55 = Dsharp5
    static let key_56 = E5
    static let key_57 = F5
    static let key_58 = Fsharp5
    static let key_59 = G5
    static let key_60 = Gsharp5
    static let key_61 = A5
    static let key_62 = Asharp5
    static let key_63 = B5
    
    static let key_64 = C6
    static let key_65 = Csharp6
    static let key_66 = D6
    static let key_67 = Dsharp6
    static let key_68 = E6
    static let key_69 = F6
    static let key_70 = Fsharp6
    static let key_71 = G6
    static let key_72 = Gsharp6
    static let key_73 = A6
    static let key_74 = Asharp6
    static let key_75 = B6
    
    static let key_76 = C7
    static let key_77 = Csharp7
    static let key_78 = D7
    static let key_79 = Dsharp7
    static let key_80 = E7
    static let key_81 = F7
    static let key_82 = Fsharp7
    static let key_83 = G7
    static let key_84 = Gsharp7
    static let key_85 = A7
    static let key_86 = Asharp7
    static let key_87 = B7
    
    static let key_88 = C8
    
    // By midi note numebr
    
    static let midi_21 = A0
    static let midi_22 = Asharp0
    static let midi_23 = B0
    
    static let midi_24 = C1
    static let midi_25 = Csharp1
    static let midi_26 = D1
    static let midi_27 = Dsharp1
    static let midi_28 = E1
    static let midi_29 = F1
    
    static let midi_30 = Fsharp1
    static let midi_31 = G1
    static let midi_32 = Gsharp1
    static let midi_33 = A1
    static let midi_34 = Asharp1
    static let midi_35 = B1
    
    static let midi_36 = C2
    static let midi_37 = Csharp2
    static let midi_38 = D2
    static let midi_39 = Dsharp2
    static let midi_40 = E2
    static let midi_41 = F2
    static let midi_42 = Fsharp2
    static let midi_43 = G2
    static let midi_44 = Gsharp2
    static let midi_45 = A2
    static let midi_46 = Asharp2
    static let midi_47 = B2
    
    static let midi_48 = C3
    static let midi_49 = Csharp3
    static let midi_50 = D3
    static let midi_51 = Dsharp3
    static let midi_52 = E3
    static let midi_53 = F3
    static let midi_54 = Fsharp3
    static let midi_55 = G3
    static let midi_56 = Gsharp3
    static let midi_57 = A3
    static let midi_58 = Asharp3
    static let midi_59 = B3
    
    static let midi_60 = C4
    static let midi_61 = Csharp4
    static let midi_62 = D4
    static let midi_63 = Dsharp4
    static let midi_64 = E4
    static let midi_65 = F4
    static let midi_66 = Fsharp4
    static let midi_67 = G4
    static let midi_68 = Gsharp4
    static let midi_69 = A4
    static let midi_70 = Asharp4
    static let midi_71 = B4
    
    static let midi_72 = C5
    static let midi_73 = Csharp5
    static let midi_74 = D5
    static let midi_75 = Dsharp5
    static let midi_76 = E5
    static let midi_77 = F5
    static let midi_78 = Fsharp5
    static let midi_79 = G5
    static let midi_80 = Gsharp5
    static let midi_81 = A5
    static let midi_82 = Asharp5
    static let midi_83 = B5
    
    static let midi_84 = C6
    static let midi_85 = Csharp6
    static let midi_86 = D6
    static let midi_87 = Dsharp6
    static let midi_88 = E6
    static let midi_89 = F6
    static let midi_90 = Fsharp6
    static let midi_91 = G6
    static let midi_92 = Gsharp6
    static let midi_93 = A6
    static let midi_94 = Asharp6
    static let midi_95 = B6
    
    static let midi_96 = C7
    static let midi_97 = Csharp7
    static let midi_98 = D7
    static let midi_99 = Dsharp7
    static let midi_100 = E7
    static let midi_101 = F7
    static let midi_102 = Fsharp7
    static let midi_103 = G7
    static let midi_104 = Gsharp7
    static let midi_105 = A7
    static let midi_106 = Asharp7
    static let midi_107 = B7
    
    static let midi_108 = C8
}

