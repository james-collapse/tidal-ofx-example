<h2>Introduction</h2>

This project demonstrates how to send messages from Tidal to openFrameworks over OSC.

<h2>Project setup</h2>

1. Clone this repository.
2. Create a new openFrameworks project, including the ofxOsc addon, using the openFrameworks Project Generator.
3. Copy the contents of `./of/apps/src` to the `src` folder of the new openFrameworks project.
4. Open the project in your IDE, build and run.

<h2>BootTidal.hs</h2>

The example relies on a modification to BootTidal.hs to send OSC messages to an additional target:

```
let sdTarget    = superdirtTarget {oLatency = 0.1, oAddress = "127.0.0.1", oPort = 57120}
    -- openFrameworks OSC target
    ofxTarget   = Target {oName = "ofx", oAddress = "127.0.0.1", oPort = 2020, oLatency = 0.1, oSchedule = Live, oWindow = Nothing, oHandshake = False, oBusPort = Nothing}
    -- openFrameworks OSC message structure
    ofxShape    = OSC "/ofx" $ ArgList [("ofx", Nothing)]
    -- Additional parameters
    ofx         = pF "ofx"

tidal <- startStream (defaultConfig {cFrameTimespan = 1/20}) [(sdTarget, [superdirtShape]), (ofxTarget, [ofxShape])]
```

Patterned messages can be sent to openFrameworks using the `ofx` parameter - for example:

```
d1
$ n "1 ~ ~ ~"
# s "bd"
# ofx 1.0
```

This would send an OSC message with an argument of `1.0` once every cycle.
