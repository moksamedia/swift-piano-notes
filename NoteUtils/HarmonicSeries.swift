//
//  HarmonicSeries.swift
//  NoteUtils
//
//  Created by Andrew Hughes on 10/16/16.
//  Copyright © 2016 Andrew Hughes. All rights reserved.
//

import Foundation


public class Partial: CustomStringConvertible, CustomDebugStringConvertible, Equatable  {
    
    public private(set) var nearestNote:Note
    public private(set) var frequency:Double
    public private(set) var centsDetuned:Double
    public private(set) var microtonalDeviation:String
    public private(set) var number:Int
    
    public init(nearestNote:Note, frequency:Double, centsDetuned:Double, microtonalDeviation:String, number:Int) {
        self.nearestNote = nearestNote
        self.frequency = frequency
        self.centsDetuned = centsDetuned
        self.microtonalDeviation = microtonalDeviation
        self.number = number
        
    }
    
    public var description:String {
                
        if (centsDetuned > 0) {
            return String(format:"(%d) %0.1f ~ %@ + %1.0f", number, frequency, nearestNote.description, centsDetuned)
        }
        else if (centsDetuned < 0) {
            return String(format:"(%d) %0.1f ~ %@ - %1.0f", number, frequency, nearestNote.description, abs(centsDetuned))
        }
        else {
            return String(format:"(%d) %0.1f ~ %@", number, frequency, nearestNote.description)
        }
        
    }
    
    public var debugDescription:String {
        if (microtonalDeviation != "") {
            return String(format:"%@, micro = %@", description, microtonalDeviation)
        }
        else {
            return description
        }
    }
    
    public static func ==(left: Partial, right: Partial) -> Bool {
        return left.number == right.number
    }
    
}

public class HarmonicSeries: CustomStringConvertible, CustomDebugStringConvertible  {
    
    public private(set) var fundamental:Note
    public private(set) var partialStretch:Double
    public private(set) var numberOfPartials:Int
    public private(set) var partials:[Partial]
    
    public func getPartial(_ num:Int) -> Partial {
        assert(num > 0 && num <= partials.count)
        return partials[num-1]
    }
    
    public var description:String {
        
        var str:String = String(format:"%@ %d => ", fundamental.description, numberOfPartials)
        
        for p in partials {
            str += p.description
            str += ", "
        }
        
        return str
    }
    
    public var debugDescription:String {
        
        var str:String = String(format:"%@ %d =>\n", fundamental.description, numberOfPartials)
        
        for p in partials {
            str += "    "
            str += p.debugDescription
            str += "\n"
        }
        
        return str
    }
    
    public init(_ fundamental: Note, _ numberOfPartials:Int, _ partialStretch:Double = 1.0) {
        
        self.partials = [Partial]()
        self.fundamental = fundamental
        self.numberOfPartials = numberOfPartials
        self.partialStretch = 1.0
        
        var multiplier:Double, partialFrequency:Double, ratio:Double, partialOctave:Int, partialOctaveStartFrequency:Double, pitchClassInteger:Int, frequencyIn12TET:Double, centsDetuned:Double, noteName:String, microtonalDeviation:String
        
        let LOG_2:Double = 0.6931471805599450;
        let SEMITONE:Double = 1.0594630943593000;
        let LOG_SEMITONE:Double = 0.0577622650466622;
        //let CENT:Double = 1.00057778950655000;
        let LOG_CENT:Double = 0.0005776226504666;
        let noteNames:[String] = ["C","C#","D","Eb","E","F","F#","G","Ab","A","Bb","B"];
        
        for i in 1...numberOfPartials {
            
            multiplier = Double(i-1) * partialStretch + 1
            
            // Calculate the frequency of this partial
            partialFrequency = fundamental.frequencyHz * multiplier
            
            // Calculate the octave of this partial
            ratio = partialFrequency / Note.C0.frequencyHz
            partialOctave = Int(floor(log(ratio) / LOG_2))
            
            // Start frequency of octave
            partialOctaveStartFrequency = Note.C0.frequencyHz * pow(2.0, Double(partialOctave))
            
            // Number of semitones up from start of octave
            ratio = partialFrequency / partialOctaveStartFrequency
            pitchClassInteger = Int(floor(log(ratio) / LOG_SEMITONE))
            
            if (pitchClassInteger == 12) {
                pitchClassInteger = 0;
                partialOctave += 1;
            }
            
            // ** GET 12TET FREQUENCY OF THIS PITCH CLASS ** //
            frequencyIn12TET = partialOctaveStartFrequency * pow(SEMITONE, Double(pitchClassInteger))
            
            ratio = partialFrequency / frequencyIn12TET
            
            centsDetuned = round(log(ratio) / LOG_CENT);
            
            // ** IF MORE THAN 50 THEN ROUND EVERYTHING UP!
            if (centsDetuned > 50) {
                pitchClassInteger += 1;
                if (pitchClassInteger == 12) {
                    pitchClassInteger = 0;
                    partialOctave += 1;
                }
                centsDetuned -= 100;
            }
            
            // Note name
            noteName = noteNames[pitchClassInteger];
            
            // Microtonal deviation
            microtonalDeviation = ""
            if (centsDetuned > 25) {
                microtonalDeviation = "+"
            } else if (centsDetuned < -25) {
                microtonalDeviation = "-"
            }
            
            //NSLog("Partial %d", i)
            
            //NSLog("%@ : %d", noteName, partialOctave)
            
            let keyboardNumber:Int = NoteConverter.noteAndOctaveToKeyboardNumber(note: noteName, octave: partialOctave)
            let nearestNote:Note = Note(keyboardNum: keyboardNumber)
            
            //NSLog(nearestNote.debugDescription)
            
            let partial:Partial = Partial(
                nearestNote: nearestNote,
                frequency: partialFrequency,
                centsDetuned: centsDetuned,
                microtonalDeviation: microtonalDeviation,
                number: i
            )
            
            partials.append(partial)
            
        }
        
        NSLog(debugDescription)
    }
    
}
