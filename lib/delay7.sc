//delayyyyyyyy by @cfd90
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

		), nil, 0.5);
		^ret;
	}

	*initClass {
		FxSetup.register(this.new);
	}

	subPath {
		^"/Fx_Delay7";
	}

	symbol {
		^\FxDelay7;
	}

	addSynthdefs {
		SynthDef(\FxDelay7, {|inBus, outBus|

			var time, feedback, sep, mix, delaysend, highpass, lowpass, out;

			var t = Lag.kr(time, 0.2);
			var f = Lag.kr(feedback, 0.2);
			var s = Lag.kr(sep, 0.2);
			var d = Lag.kr(delaysend, 0.2);
			var h = Lag.kr(highpass, 0.2);
			var l = Lag.kr(lowpass, 0,2);

			var input = In.ar(inBus, 2);
			var fb = LocalIn.ar(2);
			var output = LeakDC.ar((fb * f) + (input * d));

			output = HPF.ar(output, h);
			output = LPF.ar(output, l);
			output = output.tanh;

			output = DelayC.ar(output, 2.5, LFNoise2.ar(12).range([t, t + s], [t + s, t])).reverse;
			LocalOut.ar(output);

			Out.ar(outBus, LinXFade2.ar(input, output, mix));
		}).add;
	}

}
