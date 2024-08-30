//Delayyyyyyyy by @cfd90
//modified and ported to fx mod for norns by @imminent gloom

FxDelay7 : FxBase {

	*new {
		var ret = super.newCopyArgs(nil, \none, (
			time: 0.55,
			feedback: 0.8,
			sep: 0,
			mix: 0.4,
			delaysend: 0.8,
			highpass: 20,
			lowpass: 5000

		), nil, 1);
		^ret;
	}

	*initClass {
		FxSetup.register(this.new);
	}

	subPath {
		^"/fx_delay7";
	}

	symbol {
		^\FxDelay7;
	}

	addSynthdefs {
		SynthDef(\FxDelay7, {|inBus, outBus|
            
			var t, s;
           
			var input = In.ar(inBus, 2);
			var fb = LocalIn.ar(2);
			var output = LeakDC.ar((fb * \feedback.kr(0.8, 0.2)) + (input * \delaysend.kr(0.8, 0.8)));

			output = HPF.ar(output, \highpass.kr(20, 0.2));
			output = LPF.ar(output, \lowpass.kr(5000, 0.2));
			output = output.tanh;

            		t = \time.kr(0.55, 0.2);
            		s = \sep.kr(0.0, 0.2);

			output = DelayC.ar(output, 2.5, LFNoise2.ar(12).range([t, t + s], [t + s, t])).reverse;
			LocalOut.ar(output);

			Out.ar(outBus, LinXFade2.ar(input, output, \mix.kr(0.4)));
		}).add;
	}

}
