
//Import data.
//CSVFileReader.readInterpret reads comma-separated text files into 2D arrays line by line.
~mycsv=CSVFileReader.readInterpret("/Users/isabellabrenner/Downloads/HPEM_VM_Sample_Data.csv",true,true)

//The current file is seperated into horizontal arrays rather than vertical arrays.
//The.at(i) function accesses a row from a CSV data at the index specified by i.
//The asArray function turns the retrieved row into an array.
~time=Array.fill(~mycsv.size,{arg i;~mycsv.at(i).asArray.at(0)});
~py=Array.fill(~mycsv.size,{arg i;~mycsv.at(i).asArray.at(1)});
~suc=Array.fill(~mycsv.size,{arg i;~mycsv.at(i).asArray.at(2)});
~fum=Array.fill(~mycsv.size,{arg i;~mycsv.at(i).asArray.at(3)});
~tryp=Array.fill(~mycsv.size,{arg i;~mycsv.at(i).asArray.at(4)});

// Normalize takes the range of values of the array and inearly maps them to sound parameters.
//freq corresponds to frequency i.e., from low pitch to high pitch.
//amp corresponds to amplitude, i.e., from quiet to loud.
//attack corresponds to envelope attack time, i.e., from fast attack (sharp timbre) to slow attack (mellow timbre).
//decay corresponds to envelope decay time, i.e., from short decay time (fades quickly) to fast decay time (fades slowly).
//dur corresponds to note duration, i.e, from short notes to long notes.
~freq1=~time.normalize(100,500);
~levels1=~py.normalize(0.1,1);
~attack1=~py.normalize(0.01,0.1);
~decay1=~py.normalize(0.1,0.2);
~dur1=~py.normalize(0.01,1);

~freq2=~time.normalize(300,700);
~levels2=~suc.normalize(0.01,0.1);
~attack2=~suc.normalize(0.01,0.1);
~decay2=~suc.normalize(0.1,0.2);
~dur2=~suc.normalize(1,2);

~freq3=~time.normalize(500,9000);
~levels3=~fum.normalize(0.01,0.1);
~attack3=~fum.normalize(0.01,0.1);
~decay3=~fum.normalize(0.1,0.2);
~dur3=~fum.normalize(1,2);

~freq4=~time.normalize(600,1000);
~levels4=~fum.normalize(0.01,0.1);
~attack4=~fum.normalize(0.01,0.1);
~decay4=~fum.normalize(0.1,0.2);
~dur4=~fum.normalize(1,2);

~freq5=~time.normalize(200,400);
~levels5=~fum.normalize(0.01,0.1);
~attack5=~fum.normalize(0.01,0.1);
~decay5=~fum.normalize(0.1,0.2);
~dur5=~fum.normalize(1,2);

//create simple synth for each media.
(
p=Pbind(\instrument, \sinegrain,
	\freq, Pseq(~freq1,1),
	\attack, Pseq(~attack1,),
	\decay, Pseq(~decay1,1),
	\pan, 0,
	\dur, Pseq(~dur1,1),
	\amp, Pseq(~levels1,1)
).play;
)
p.stop;

(
p=Pbind(\instrument, \sinegrain,
	\freq, Pseq(~freq2,1),
	\attack, Pseq(~attack2,),
	\decay, Pseq(~decay2,1),
	\pan, 0,
	\dur, Pseq(~dur2,1),
	\amp, Pseq(~levels2,1)
).play;
)
p.stop;

(
p=Pbind(\instrument, \sinegrain,
	\freq, Pseq(~freq3,1),
	\attack, Pseq(~attack3,),
	\decay, Pseq(~decay3,1),
	\pan, 0,
	\dur, Pseq(~dur3,1),
	\amp, Pseq(~levels3,1)
).play;
)
p.stop;

(
p=Pbind(\instrument, \sinegrain,
	\freq, Pseq(~freq4,1),
	\attack, Pseq(~attack4,),
	\decay, Pseq(~decay4,1),
	\pan, 0,
	\dur, Pseq(~dur4,1),
	\amp, Pseq(~levels4,1)
).play;
)
p.stop;

(
p=Pbind(\instrument, \sinegrain,
	\freq, Pseq(~freq5,1),
	\attack, Pseq(~attack5,),
	\decay, Pseq(~decay5,1),
	\pan, 0,
	\dur, Pseq(~dur5,1),
	\amp, Pseq(~levels5,1)
).play;
)
p.stop;

