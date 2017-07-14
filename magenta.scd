s.quit;
s.boot;

Quarks.gui;

MIDIClient.init;
m = MIDIOut(2);



m.connect(2);

(
t= Task({
	4.do({
       m.noteOn(16, 60, 60);
       m.noteOn(16, 61, 60);
       m.noteOff(16, 61, 60);
		0.1.wait;
       m.allNotesOff(16);
	});
});
)

t.start;

(
p = Pbind(
    \type, \midi,
    \midicmd, \noteOn,
    \midiout, m,
    \chan, 0,
    \degree, Pwhite(-7, 12, inf),
    \dur, Pwrand([0.25, Pn(0.125, 2)], #[0.8, 0.2], inf),
    \legato, sin(Ptime(inf) * 0.5).linexp(-1, 1, 1/3, 3),
    \amp, Pexprand(0.5, 1.0, inf)
).play(quant: 1);
)
p.play;
p.stop;
