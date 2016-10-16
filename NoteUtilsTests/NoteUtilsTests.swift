//
//  NoteUtilsTests.swift
//  NoteUtilsTests
//
//  Created by Andrew Hughes on 10/15/16.
//  Copyright © 2016 Andrew Hughes. All rights reserved.
//

import XCTest
@testable import NoteUtils

class NoteUtilsTests: XCTestCase {

    
    func testBetweenNumberAndOctaves() {
        
        XCTAssertEqual( 69, NoteConverter.noteAndOctaveToMidiNoteNumber(note: "A", octave: 4));
        XCTAssertEqual( 21, NoteConverter.noteAndOctaveToMidiNoteNumber(note: "A", octave: 0));
        XCTAssertEqual( 108, NoteConverter.noteAndOctaveToMidiNoteNumber(note: "C", octave: 8));
        XCTAssertEqual( 83, NoteConverter.noteAndOctaveToMidiNoteNumber(note: "B", octave: 5));
        
        XCTAssertEqual( "A1", NoteConverter.midiNoteNumberToNoteAndKeyboardNumber(noteNumber:21));
        XCTAssertEqual( "E8", NoteConverter.midiNoteNumberToNoteAndKeyboardNumber(noteNumber:28));
        XCTAssertEqual( "A49", NoteConverter.midiNoteNumberToNoteAndKeyboardNumber(noteNumber:69));
        XCTAssertEqual( "C88", NoteConverter.midiNoteNumberToNoteAndKeyboardNumber(noteNumber:108));
        
        XCTAssertEqual( "C8", NoteConverter.midiNoteNumberToNoteAndOctave(noteNumber:108));
        XCTAssertEqual( "C4", NoteConverter.midiNoteNumberToNoteAndOctave(noteNumber:60));
        XCTAssertEqual( "A0", NoteConverter.midiNoteNumberToNoteAndOctave(noteNumber:21));
        XCTAssertEqual( "D6", NoteConverter.midiNoteNumberToNoteAndOctave(noteNumber:86));
        
    }
    
    
    func testBetweenNumberAndOctavesTuples() {
        
        var tuple:(String,Int) = NoteConverter.midiNoteNumberToNoteAndOctaveAsTuple(noteNumber:86)
        XCTAssertEqual( "D", tuple.0 );
        XCTAssertEqual( 6, tuple.1 );
        
        tuple = NoteConverter.midiNoteNumberToNoteAndOctaveAsTuple(noteNumber:60)
        XCTAssertEqual( "C", tuple.0 );
        XCTAssertEqual( 4, tuple.1 );
        
        tuple = NoteConverter.midiNoteNumberToNoteAndOctaveAsTuple(noteNumber:108)
        XCTAssertEqual( "C", tuple.0 );
        XCTAssertEqual( 8, tuple.1 );

        tuple = NoteConverter.midiNoteNumberToNoteAndKeyboardNumberAsTuple(noteNumber:108)
        XCTAssertEqual( "C", tuple.0 );
        XCTAssertEqual( 88, tuple.1 );
        
        tuple = NoteConverter.midiNoteNumberToNoteAndKeyboardNumberAsTuple(noteNumber:21)
        XCTAssertEqual( "A", tuple.0 );
        XCTAssertEqual( 1, tuple.1 );
        
        tuple = NoteConverter.midiNoteNumberToNoteAndKeyboardNumberAsTuple(noteNumber:64)
        XCTAssertEqual( "E", tuple.0 );
        XCTAssertEqual( 44, tuple.1 );
        
        tuple = NoteConverter.midiNoteNumberToNoteAndKeyboardNumberAsTuple(noteNumber:43)
        XCTAssertEqual( "G", tuple.0 );
        XCTAssertEqual( 23, tuple.1 );
    }
    
    func testNoteAndOctaveToMidiNoteNumber() {
        XCTAssertEqual( 108, NoteConverter.noteAndOctaveToMidiNoteNumber(note:"C", octave:8));
        XCTAssertEqual( 21, NoteConverter.noteAndOctaveToMidiNoteNumber(note:"A", octave:0));
        XCTAssertEqual( 56, NoteConverter.noteAndOctaveToMidiNoteNumber(note:"Ab", octave:3));
        XCTAssertEqual( 71, NoteConverter.noteAndOctaveToMidiNoteNumber(note:"B", octave:4));
        XCTAssertEqual( 78, NoteConverter.noteAndOctaveToMidiNoteNumber(note:"F#", octave:5));
    }
    
    func testNoteAndOctaveToKeyboardNumer() {
        XCTAssertEqual( 88, NoteConverter.noteAndOctaveToKeyboardNumber(note:"C", octave:8));
        XCTAssertEqual( 1, NoteConverter.noteAndOctaveToKeyboardNumber(note:"A", octave:0));
        XCTAssertEqual( 33, NoteConverter.noteAndOctaveToKeyboardNumber(note:"F", octave:3));
        XCTAssertEqual( 78, NoteConverter.noteAndOctaveToKeyboardNumber(note:"D", octave:7));
        XCTAssertEqual( 58, NoteConverter.noteAndOctaveToKeyboardNumber(note:"F#", octave:5));
    }
    
    func testMidiNoteNumberToKeyboardNumberAndVisaVersa() {
        XCTAssertEqual( 88, NoteConverter.midiNoteNumberToKeyboardNumber(noteNumber:108));
        XCTAssertEqual( 1, NoteConverter.midiNoteNumberToKeyboardNumber(noteNumber:21));
        XCTAssertEqual( 108, NoteConverter.keyboardNumberToMidiNoteNumber(keyboardNumber:88));
        XCTAssertEqual( 21, NoteConverter.keyboardNumberToMidiNoteNumber(keyboardNumber:1));
    }
    
    func testKeyboardNumberToAll() {
  
        var result:Dictionary<String, Any> = NoteConverter.keyboardNumberToAll(keyboardNumber: 40)
        
        XCTAssertEqual(4, result["octave"] as! Int)
        XCTAssertEqual("C", result["noteName"] as! String)
        XCTAssertEqual(40, result["keyboardNoteNumber"] as! Int)
        XCTAssertEqual(60, result["midiNoteNumber"] as! Int)

        result = NoteConverter.keyboardNumberToAll(keyboardNumber: 78)
        
        XCTAssertEqual(7, result["octave"] as! Int)
        XCTAssertEqual("D", result["noteName"] as! String)
        XCTAssertEqual(78, result["keyboardNoteNumber"] as! Int)
        XCTAssertEqual(98, result["midiNoteNumber"] as! Int)
    
        result = NoteConverter.keyboardNumberToAll(keyboardNumber: 88)
        
        XCTAssertEqual(8, result["octave"] as! Int)
        XCTAssertEqual("C", result["noteName"] as! String)
        XCTAssertEqual(88, result["keyboardNoteNumber"] as! Int)
        XCTAssertEqual(108, result["midiNoteNumber"] as! Int)
        
        result = NoteConverter.keyboardNumberToAll(keyboardNumber: 1)
        
        XCTAssertEqual(0, result["octave"] as! Int)
        XCTAssertEqual("A", result["noteName"] as! String)
        XCTAssertEqual(1, result["keyboardNoteNumber"] as! Int)
        XCTAssertEqual(21, result["midiNoteNumber"] as! Int)
    }
    
    func testPitchEqualTemperment() {

        XCTAssertEqualWithAccuracy(
            261.63,
            NoteConverter.pitchForKeyboardNumber_EqualTemperment(keyboardNumber:40),
            accuracy:0.1)

        var keyboardNumber:Int = NoteConverter.noteAndOctaveToKeyboardNumber(note:"G", octave:4)
        
        XCTAssertEqualWithAccuracy(
            392.00,
            NoteConverter.pitchForKeyboardNumber_EqualTemperment(keyboardNumber:keyboardNumber),
            accuracy:0.1)
        
        keyboardNumber = NoteConverter.noteAndOctaveToKeyboardNumber(note:"D", octave:3)
        
        XCTAssertEqualWithAccuracy(
            146.83,
            NoteConverter.pitchForKeyboardNumber_EqualTemperment(keyboardNumber:keyboardNumber),
            accuracy:0.1)
        
        keyboardNumber = NoteConverter.noteAndOctaveToKeyboardNumber(note:"B", octave:8)
        
        XCTAssertEqualWithAccuracy(
            7902.13,
            NoteConverter.pitchForKeyboardNumber_EqualTemperment(keyboardNumber:keyboardNumber),
            accuracy:0.1)
        
        keyboardNumber = NoteConverter.noteAndOctaveToKeyboardNumber(note:"C", octave:0)
        
        XCTAssertEqualWithAccuracy(
            16.35,
            NoteConverter.pitchForKeyboardNumber_EqualTemperment(keyboardNumber:keyboardNumber),
            accuracy:0.1)
    }
    
    func testStaticNotes() {
        
        XCTAssertEqualWithAccuracy(
            27.50,
            Note.A0.frequencyHz,
            accuracy:0.01
        )
        
        XCTAssertEqualWithAccuracy(
            30.868,
            Note.B0.frequencyHz,
            accuracy:0.01
        )
        
        XCTAssertEqualWithAccuracy(
            55.0,
            Note.A1.frequencyHz,
            accuracy:0.01
        )
        
        XCTAssertEqualWithAccuracy(
            61.735,
            Note.B1.frequencyHz,
            accuracy:0.01
        )
        
        XCTAssertEqualWithAccuracy(
            110.00,
            Note.A2.frequencyHz,
            accuracy:0.01
        )
        
        XCTAssertEqualWithAccuracy(
            82.407,
            Note.E2.frequencyHz,
            accuracy:0.01
        )
    
        XCTAssertEqualWithAccuracy(
            220.0,
            Note.A3.frequencyHz,
            accuracy:0.01
        )
        
        XCTAssertEqualWithAccuracy(
            233.08,
            Note.Bb3.frequencyHz,
            accuracy:0.01
        )
        
        XCTAssertEqualWithAccuracy(
            130.81,
            Note.C3.frequencyHz,
            accuracy:0.1
        )
        
        XCTAssertEqualWithAccuracy(
            830.61,
            Note.Gsharp5.frequencyHz,
            accuracy:0.1
        )
        
        XCTAssertEqualWithAccuracy(
            1864.7,
            Note.Bb6.frequencyHz,
            accuracy:0.1
        )
        
        
        XCTAssertEqualWithAccuracy(
            3322.4,
            Note.Ab7.frequencyHz,
            accuracy:0.1
        )
        
        XCTAssertEqualWithAccuracy(
            4186.0,
            Note.C8.frequencyHz,
            accuracy:0.1
        )
    }
    
    func testCreatePartialSeriesC4() {
        
        let hs:HarmonicSeries = HarmonicSeries(Note.C4, 16)
        
        NSLog(hs.description)
        NSLog(hs.debugDescription)

        XCTAssertTrue(Note.C4 == hs.fundamental)
        XCTAssertEqual(16, hs.numberOfPartials)
        XCTAssertEqualWithAccuracy(1.0, hs.partialStretch, accuracy: 0.1)
        
        // 1
        var partial = hs.getPartial(1)
        XCTAssertEqual(partial.nearestNote, Note.C4)
        XCTAssertEqualWithAccuracy(partial.frequency, 261.625, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 0, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")

        //2
        partial = hs.getPartial(2)
        XCTAssertEqual(partial.nearestNote, Note.C5)
        XCTAssertEqualWithAccuracy(partial.frequency, 523.251, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 0, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")

        //3
        partial = hs.getPartial(3)
        XCTAssertEqual(partial.nearestNote, Note.G5)
        XCTAssertEqualWithAccuracy(partial.frequency, 784.876, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 2, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //4
        partial = hs.getPartial(4)
        XCTAssertEqual(partial.nearestNote, Note.C6)
        XCTAssertEqualWithAccuracy(partial.frequency, 1046.502, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 0, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //5
        partial = hs.getPartial(5)
        XCTAssertEqual(partial.nearestNote, Note.E6)
        XCTAssertEqualWithAccuracy(partial.frequency, 1308.127, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, -14, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //6
        partial = hs.getPartial(6)
        XCTAssertEqual(partial.nearestNote, Note.G6)
        XCTAssertEqualWithAccuracy(partial.frequency, 1569.753, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 2, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //10
        partial = hs.getPartial(10)
        XCTAssertEqual(partial.nearestNote, Note.E7)
        XCTAssertEqualWithAccuracy(partial.frequency, 2616.255, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, -14, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //14
        partial = hs.getPartial(14)
        XCTAssertEqual(partial.nearestNote, Note.Bb7)
        XCTAssertEqualWithAccuracy(partial.frequency, 3662.757, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, -31, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "-")
        
        //16
        partial = hs.getPartial(16)
        XCTAssertEqual(partial.nearestNote, Note.C8)
        XCTAssertEqualWithAccuracy(partial.frequency, 4186.009, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 0, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
    }
    
    func testCreatePartialSeriesGsharp3() {
        
        let hs:HarmonicSeries = HarmonicSeries(Note.Gsharp3, 16)
        
        XCTAssertTrue(Note.Gsharp3 == hs.fundamental)
        XCTAssertEqual(16, hs.numberOfPartials)
        XCTAssertEqualWithAccuracy(1.0, hs.partialStretch, accuracy: 0.1)
        
        // 1
        var partial = hs.getPartial(1)
        XCTAssertEqual(partial.nearestNote, Note.Ab3)
        XCTAssertEqualWithAccuracy(partial.frequency, 207.652, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 0, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //2
        partial = hs.getPartial(2)
        XCTAssertEqual(partial.nearestNote, Note.Ab4)
        XCTAssertEqualWithAccuracy(partial.frequency, 415.304, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 0, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //3
        partial = hs.getPartial(3)
        XCTAssertEqual(partial.nearestNote, Note.Eb5)
        XCTAssertEqualWithAccuracy(partial.frequency, 622.957, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 2, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //4
        partial = hs.getPartial(4)
        XCTAssertEqual(partial.nearestNote, Note.Ab5)
        XCTAssertEqualWithAccuracy(partial.frequency, 830.609, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 0, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //5
        partial = hs.getPartial(5)
        XCTAssertEqual(partial.nearestNote, Note.C6)
        XCTAssertEqualWithAccuracy(partial.frequency, 1038.261, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, -14, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //6
        partial = hs.getPartial(6)
        XCTAssertEqual(partial.nearestNote, Note.Eb6)
        XCTAssertEqualWithAccuracy(partial.frequency, 1245.914, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 2, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //7
        partial = hs.getPartial(7)
        XCTAssertEqual(partial.nearestNote, Note.Fsharp6)
        XCTAssertEqualWithAccuracy(partial.frequency, 1453.566, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, -31, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "-")
        
        //8
        partial = hs.getPartial(8)
        XCTAssertEqual(partial.nearestNote, Note.Ab6)
        XCTAssertEqualWithAccuracy(partial.frequency, 1661.218, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 0, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //9
        partial = hs.getPartial(9)
        XCTAssertEqual(partial.nearestNote, Note.Bb6)
        XCTAssertEqualWithAccuracy(partial.frequency, 1868.871, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 4, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //10
        partial = hs.getPartial(10)
        XCTAssertEqual(partial.nearestNote, Note.C7)
        XCTAssertEqualWithAccuracy(partial.frequency, 2076.523, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, -14, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //11
        partial = hs.getPartial(11)
        XCTAssertEqual(partial.nearestNote, Note.D7)
        XCTAssertEqualWithAccuracy(partial.frequency, 2284.175, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, -49, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "-")
        
        //12
        partial = hs.getPartial(12)
        XCTAssertEqual(partial.nearestNote, Note.Eb7)
        XCTAssertEqualWithAccuracy(partial.frequency, 2491.828, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 2, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //13
        partial = hs.getPartial(13)
        XCTAssertEqual(partial.nearestNote, Note.E7)
        XCTAssertEqualWithAccuracy(partial.frequency, 2699.48, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 41, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "+")
        
        //14
        partial = hs.getPartial(14)
        XCTAssertEqual(partial.nearestNote, Note.Fsharp7)
        XCTAssertEqualWithAccuracy(partial.frequency, 2907.132, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, -31, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "-")
        
        //15
        partial = hs.getPartial(15)
        XCTAssertEqual(partial.nearestNote, Note.G7)
        XCTAssertEqualWithAccuracy(partial.frequency, 3114.785, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, -12, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
        
        //16
        partial = hs.getPartial(16)
        XCTAssertEqual(partial.nearestNote, Note.Ab7)
        XCTAssertEqualWithAccuracy(partial.frequency, 3322.437, accuracy: 0.001)
        XCTAssertEqualWithAccuracy(partial.centsDetuned, 0, accuracy: 0.1)
        XCTAssertEqual(partial.microtonalDeviation, "")
    }

}
