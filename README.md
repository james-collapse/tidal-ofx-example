Project setup

1. Clone this repository.
2. Create a new openFrameworks project, including the ofxOsc addon, using the openFrameworks Project Generator.
3. Copy the contents of `[Your repository location]\tidal-av-project\of\apps\oscTemplate\src` to the `src` folder of the new openFrameworks project.
4. Open in your IDE, build and run.

BootTidal.hs

The project relies on a modification to the BootTidal.hs file to send OSC messages to two targets:

1. The default, over port 51720;
2. A custom target, over port 2020.

```
let oscplay = OSC "/oscplay" Named {requiredArgs = ["mode"]}

tidal <- startStream (defaultConfig {cFrameTimespan = 1/20}) [(superdirtTarget {oLatency = 0.2, oAddress = "127.0.0.1", oPort = 57120}, [superdirtShape]), (superdirtTarget {oAddress = "127.0.0.1", oPort = 2020, oSchedule = Live}, [oscplay])]
```

You can either make this modification to your own BootTidal.hs file, or point the Tidalcycles extension in VS Code or Atom to the boot file from this repository:

`[Your repository location]\tidal-av-project\tidal\BootTidal.hs`

The modification means that all messages are sent to SuperCollider, but those with a `mode` control pattern are also sent over port 2020.*
 
To use this control pattern in your Tidal messages, add the following line to your .tidal file:

`let mode = pF "mode"`

This line needs to be sent from Tidal before any messages including a `mode` control pattern are sent, otherwise those messages will be considered invalid.

Then add a control pattern using `mode`, for example:

```
d1
$ n "~ 1 _ ~ 1 _ ~ 1"
# s "hats"
# pan 0.5
# legato 0.25
# gain 1.0
# mode "~ 0.3 _ ~ 0.6 _ ~ 1.0"
```

You can test the openFrameworks project by:

1. Running it your chosen IDE - you should see a red circle in the centre of the application window.
2. Sending a message with a `mode` control pattern from Tidal.

The colour of the circle should modulate in time with the control pattern.

*The purpose of this is to limit the messages received in openFrameworks. Since the messages are scheduled 'live' and not scheduled by the receiving application, too many messages sent at once could result in some events being dropped.