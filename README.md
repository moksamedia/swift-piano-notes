# swift-piano-notes: a simple library for working with piano notes in various formats

## Features

#### Quickly and easily work with musical notes. Library is specialized for the piano, at least in the range of notes it allows.

#### Allows user to use an object-oriented and typed representation of piano notes/keys and harmonic series with partials.

Convert between various note formats:
  - midi note number: 21 - 108
  - key number: 1 - 88
  - note name + octave: A0 - C8

Calculate partial series for any given note
- calculates frequency in Hz of partial
- finds neared note in equal temperment
- calculates cents deviation from nearest note in equal temperment
- allows for octave stretch
