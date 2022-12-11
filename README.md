<h2>Introduction</h2>

This project demonstrates how to send messages from Tidal to openFrameworks over OSC.

[Demo video](https://vimeo.com/779945173)

<h3>What is Tidal?</h3>

[TidalCycles](https://tidalcycles.org/) (or 'Tidal' for short) allows you to make patterns with code. It includes language for describing flexible (e.g. polyphonic, polyrhythmic, generative) sequences of sounds, notes, parameters, and all kind of information.

Tidal works together with [SuperCollider](https://supercollider.github.io/) and [SuperDirt](https://github.com/musikinformatik/SuperDirt) for audio output. SuperDirt does the job of interpreting Tidal patterns as commands to run in SuperCollider, while SuperCollider handles sound synthesis and output.

Tidal can run in a text editor or on the command line. A user can write a pattern in the Tidal language, listen to the results, and update the pattern, all in real-time. This makes Tidal ideal for improvisation and performance.

<h3>What is openFrameworks?</h3>

[openFrameworks](https://openframeworks.cc/) is a creative coding toolkit written in C++. It offers a set of tools for developing graphical applications, with classes for including images, sounds, video, 3D graphics, shaders, and more.

<h3>What is OSC?</h3>

[Open Sound Control (OSC)](https://en.wikipedia.org/wiki/Open_Sound_Control) is a standard protocol for transferring messages across a network. It's supported by a variety of applications, including TidalCycles, openFrameworks, Processing, Pure Data and Max for Live.

<h3>Tidal environment</h3>

When a pattern is sent from Tidal, it is sent as a bundle of OSC events to a destination. The structure and destination for those events is configured in the Tidal [boot file](https://tidalcycles.org/docs/configuration/boot-tidal/). By editing the boot file, you can use Tidal to send arbitrary patterns to any application that supports OSC.

The aim of this project is to show how Tidal patterns can be sent to both SuperCollider and openFrameworks.

<h2>Requirements</h2>

This project assumes the following are set up on your PC:

* TidalCycles
* SuperCollider
* SuperDirt
* openFrameworks

To set up Tidal, SuperCollider and SuperDirt, follow the [Tidal installation](https://tidalcycles.org/docs/).

To set up openFrameworks, follow the [openFrameworks installation](https://openframeworks.cc/download/).

<h2>Project setup</h2>

1. Clone this repository.
2. Create a [new openFrameworks project](https://openframeworks.cc/learning/01_basics/create_a_new_project/) with the ofxOsc addon included.
3. Copy the contents of `ofx/apps/src` from your clone to the `src` folder of the new project.
4. Copy the contents of `ofx/apps/data` from your clone to the `bin/data` folder of the new project.
5. Build the openFrameworks project.

<h2>Tidal setup</h2>

The example relies on a modification to the Tidal [boot file](https://tidalcycles.org/docs/configuration/boot-tidal/) to send OSC messages to an additional target. You can either use the boot file included in this repository under `tidal/BootTidal.hs`, or make the following change to your own boot file:

```
let sdTarget    = superdirtTarget {oLatency = 0.1, oAddress = "127.0.0.1", oPort = 57120}
    -- openFrameworks OSC target
    ofxTarget   = Target {oName = "ofx", oAddress = "127.0.0.1", oPort = 2020, oLatency = 0.1, oSchedule = Live, oWindow = Nothing, oHandshake = False, oBusPort = Nothing}
    -- openFrameworks OSC message structure
    ofxShape    = OSC "/ofx" $ ArgList [("ofx", Nothing), ("vowel", Just $ VS "")]
    -- Additional parameters
    ofx         = pF "ofx"

tidal <- startStream (defaultConfig {cFrameTimespan = 1/20}) [(sdTarget, [superdirtShape]), (ofxTarget, [ofxShape])]
```

For more information about setting up OSC targets, see the [Tidal OSC documentation](http://tidalcycles.org/docs/configuration/MIDIOSC/osc/).

<h2>Running</h2>

After loading Tidal in your text editor, run the openFrameworks application - a new window should appear with a black circle at the centre. 

Next, send a pattern from Tidal containing `ofx` and `vowel` parameters - for example:

```
d1
$ n "1 ~ 1 1"
# s "bd"
# ofx 1.0
# vowel "a _ e i"
```

The brightness of the circle should change in time with the pattern, and you should see the `vowel` value appear in the upper left corner.
