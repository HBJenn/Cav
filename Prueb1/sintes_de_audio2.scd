//====================
// SynthDefs de audio
//====================

// Notas:
// Necesitas colocar tus sonidos en una carpeta y organizarlos en mono y estéreo
// Sonidos cortos funcionan bien, entre 1 y 10 segundos. Pueden ser más largos.

// Instrucciones:
// 1 prender supercollider con s.boot
// 2 carga los sonidos en un Buffer
// 3 coloca la ruta de tu sonido
// 4 declara los Buffers
// 5 declara los Synthes
// 6 abre el documento de secuencias de sonido para tocar o componer

s.boot; // PRENDER SuperCollider

// Ruta en Linux para declarar buffers
(
b = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "/Sonidos/oc-s");
c = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "Sonidos/kick.wav");
d = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "Sonidos/udu-s.wav");
e = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "Sonidos/tam.wav");
f = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "Sonidos/sn1-s.wav");
g = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "Sonidos/grave-s.wav");
);

// Ruta en Mac
// b = Buffer.read(s, "/Users/name/Desktop/folder/sonido2.wav");

// Ruta en Windows, nota la letra C. Debes voltear las diagonales pues windows las pone al revés \
// b = Buffer.read(s, "C:/Users/name/Desktop/folder/sonido2.wav");

// SynthDef Mono. Es ideal para hacer mover el sonido entre bocinas con paneo.
(
(
SynthDef(\audio1, {|rate=1, sp=0, at=0.001, sus=1, rel=0.001, pan=0, amp=1, out=0|
					var son, hpf, paneo, env;
					son=PlayBuf.ar(b.numChannels, b.bufnum, rate, 1, sp * b.numFrames, 0);
					hpf=HPF.ar(son, 20);
					paneo=Pan2.ar(hpf, pan, amp);
					env=EnvGen.kr(Env.new([0, 1, 1, 0], [at, sus * b.duration, rel]), doneAction: 2);
					Out.ar(out, paneo * env);
				}).add;
);

// SynthDef Estéreo. Es ideal para sonidos ambientales largos
(
SynthDef(\audio2, {|rate=1, sp=0, at=0.001, sus=1, rel=0.001, pan=0, amp=1, out=0|
					var son, hpf, paneo, env;
					son=PlayBuf.ar(c.numChannels, c.bufnum, rate, 1, sp * c.numFrames, 0);
					hpf=HPF.ar(son, 20);
					paneo=Pan2.ar(hpf, pan, amp);
					env=EnvGen.kr(Env.new([0, 1, 1, 0], [at, sus * c.duration, rel]), doneAction: 2);
					Out.ar(out, paneo * env);
				}).add;
);

(
SynthDef(\audio3, {|rate=1, sp=0, at=0.001, sus=1, rel=0.001, pan=0, amp=1, out=0|
					var son, hpf, paneo, env;
					son=PlayBuf.ar(d.numChannels, d.bufnum, rate, 1, sp * d.numFrames, 0);
					hpf=HPF.ar(son, 20);
					paneo=Pan2.ar(hpf, pan, amp);
					env=EnvGen.kr(Env.new([0, 1, 1, 0], [at, sus * d.duration, rel]), doneAction: 2);
					Out.ar(out, paneo * env);
				}).add;
);

(
SynthDef(\audio4, {|rate=1, sp=0, at=0.001, sus=1, rel=0.001, pan=0, amp=1, out=0|
					var son, hpf, paneo, env;
					son=PlayBuf.ar(e.numChannels, e.bufnum, rate, 1, sp * e.numFrames, 0);
					hpf=HPF.ar(son, 20);
					paneo=Pan2.ar(hpf, pan, amp);
					env=EnvGen.kr(Env.new([0, 1, 1, 0], [at, sus * e.duration, rel]), doneAction: 2);
					Out.ar(out, paneo * env);
				}).add;
);

(
SynthDef(\audio5, {|rate=1, sp=0, at=0.001, sus=1, rel=0.001, pan=0, amp=1, out=0|
					var son, hpf, paneo, env;
					son=PlayBuf.ar(f.numChannels, f.bufnum, rate, 1, sp * f.numFrames, 0);
					hpf=HPF.ar(son, 20);
					paneo=Pan2.ar(hpf, pan, amp);
					env=EnvGen.kr(Env.new([0, 1, 1, 0], [at, sus * f.duration, rel]), doneAction: 2);
					Out.ar(out, paneo * env);
				}).add;
);

(
SynthDef(\audio6, {|rate=1, sp=0, at=0.001, sus=1, rel=0.001, pan=0, amp=1, out=0|
					var son, hpf, paneo, env;
					son=PlayBuf.ar(g.numChannels, g.bufnum, rate, 1, sp * g.numFrames, 0);
					hpf=HPF.ar(son, 20);
					paneo=Pan2.ar(hpf, pan, amp);
					env=EnvGen.kr(Env.new([0, 1, 1, 0], [at, sus * g.duration, rel]), doneAction: 2);
					Out.ar(out, paneo * env);
				}).add;
);

// --- Reverberación - bus 9
(
SynthDef(\rev, {|in = 9, mix = 0.4, room = 0.9, damp = 0.1, amp = 1, gate = 1, out = 0|
	var sen, env;
	sen = FreeVerb.ar(InFeedback.ar(in, 2), mix, room, damp, amp);
	env = EnvGen.kr(Env.asr(0.01, 1, 0.1), gate, doneAction: 0);
	Out.ar(out, sen * env);
}).add
);
);

// Activar efecto
~rev=Synth(\rev); // 9 Reverberación

// Modificación de efecto
~rev.set(\mix, 0.5, \room, 0.5, \damp, 0.5);

// Probar sonidos

Synth(\audio1);
Synth(\audio2);
Synth(\audio3);
Synth(\audio4);
Synth(\audio5);
Synth(\audio6);

s.quit; // APAGAR SuperCollider