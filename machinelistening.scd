s.boot;

s.quit;

(
d = Buffer.read(s, "/Users/mk365/Desktop/INTERFACES/PRESENT2/HOUSEROTATION/tracks/10.wav");

b = Buffer.alloc(s, 4096, 1);
)
MIDIClient
(
x = {
	var in, fft;
	var key;

	in = PlayBuf.ar(1, d.bufnum, BufRateScale.kr(d.bufnum), 1, 0, 1);

	fft = FFT(b.bufnum, in);

	key = KeyTrack.kr(fft, 0.2, 0.5);

	key.poll;

	Out.ar(0, Pan2.ar(in));
}.play;
)

x.free;
b.free;



b = Buffer.alloc(s, 1024, 1);
(
x={
	var in , fft, loudness;

	in = SoundIn.ar(1);

	fft = FFT(b.bufnum, in);

	loudness = Loudness(fft);

	loudness.poll(20);

	Out.ar(0, Pan2.ar(in));
}.play;
)

(


MIDIClient.init;
m = MIDIOut(2);

t= Task({
	4.do({
       m.noteOn(16, 60, 60);
       m.noteOn(16, 61, 60);
       m.noteOff(16, 61, 60);
		0.1.wait;
       m.allNotesOff(16);
	});
});

(
x={
	var in, amp, freq, hasFreq, out;
	in = SoundIn.ar(1);
	amp = Amplitude.ar(in);
	# freq, hasFreq = Pitch.kr(in);
	LFTri.ar(freq*[1, 2])* amp;
	 m.noteOn(16, 61, 60);
     m.noteOff(16, 61, 60);
}.play;
)

Synth(\midinotesound, |in, freq, hasFreq, out|
	var src, env;
	in = SoundIn.ar(1);
	amp = Amplitude.ar(in);
	# freq, hasFreq = Pitch.kr(in);
	LFTri.ar(freq*[1, 2])* amp;