# Coding challenge

## Introduction

This project contains a simple audio synthesizer written in Swift.
**Try it out and make yourself comfortable with the code!**

The heart of this project is in the `Synth.swift` file which contains the code
responsible for creating the sound (with help from `Oscillator.swift`)


## Todo

- Rewrite `Synth.swift` and `Oscillator.swift` in **Objective-C** and add it to this project
- Remove those two Swift files from the project and test it with your Obj-C implementation 
- They must work the same way as their counterpart in Swift
- Describe (not implement) how you would add the possibility to have 3 voices (synthesizers) at the same time

*this point is easy you just create three of (AVAudioSourceNode) with three different voice 
*then attach nodes to your audion audioEngine
    
   * [audioEngine attachNode:node2];
   * [audioEngine connect:node2 to:mainMixer format:inputFormat];
    
you can create shared Synth object with array of wavForm you need 
and create node based in array and attch them engine.
   

## Bonus

- Write a method in the `Synth.m` resp. `Synth.h` that informs the UI whenever audio is playing
- Display in the UI the String "Playing..." in some way when this method returns true, "" when it's false


## Rules

1. Create a repo on Github or Bitbucket and push this project (Don't fork!)
2. Make commits as often as possible! *(We want see what you do and how you do it)*
3. When you finish, send us the link to your repo by email
4. Please don't spend more than two hours on it! (1h should be fine)


### Why we use coding challenges to interview developers

Hiring is one of the most time-intensive and critical processes.
We know there are numbers of different approaches on this (and some pretty passionate opinions about it) but this approach works for us.
We first start with a coding challenge (like this one) in order to quickly evaluate the coding level of the candidate. Depending on the results of this challenge, we will invite you for more thorough interviews such as cultural fit and more technical knowledge. Recruiting is a mutual process. Feel free to ask us any questions as well.
Good luck!

What we want to evaluate with this coding challenge::

**Can you write any code?**
Basically, we need to see if you can write any code at all. We believe that you can. Still, there are many wantacoders out there and it's difficult to tell from a CV only.
Moreover, you’d be surprised how many candidates fall short when it’s time to put the cursor to the editor.

This is a pre-screening and we keep it really short. 1-2h should be fine for a skilled programmer to complete the task.
That's the only code you have to write. No online-challenges, coding puzzles or similar...
If we are happy with the result, we would like to invite you for further interviews on a personal level.

We know at some companies, it can be frustrating to send in coding challenges and never hear back from them anymore.
That's **not** how **we** work and think! So, you will get a feedback from us, no matter if we want to continue with you or not.

PROMISED!

Again, Good Luck!
The Pictural team
