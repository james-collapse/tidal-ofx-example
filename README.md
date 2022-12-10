<h2>Introduction</h2>

This project demonstrates how to send messages from Tidal to openFrameworks over OSC.

[Demo video](https://vimeo.com/779945173)

<h2>Project setup</h2>

1. Clone this repository.
2. Create a [new openFrameworks project](https://openframeworks.cc/learning/01_basics/create_a_new_project/) including the ofxOsc addon.
3. Copy the contents of `ofx/apps/src` to the `src` folder of the new project.
4. Copy the contents of `ofx/apps/data` to the `bin/data` folder of the new project.
5. Open the project in your IDE, clean and build.

<h2>TidalCycles setup</h2>

The example relies on a modification to the TidalCycles [boot file](https://tidalcycles.org/docs/configuration/boot-tidal/) to send OSC messages to an additional target. You can either use the boot file included in this repository under `tidal/BootTidal.hs`, or make the following change to your own boot file:

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

Once modified, reboot TidalCycles in your text editor.

After rebooting TidalCycles, run the openFrameworks application - a new window should appear with a black circle at the centre. 

Next, send a pattern from Tidal containing `ofx` and `vowel` parameters - for example:

```
d1
$ n "1 ~ 1 1"
# s "bd"
# ofx 1.0
# vowel "a _ e i"
```

The brightness of the circle should change, and you should see the vowel character appear in the upper left corner.

For more information about setting up OSC targets, see the [TidalCycles OSC documentation](http://tidalcycles.org/docs/configuration/MIDIOSC/osc/).
