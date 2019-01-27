(
// tuning data
var root = 100;

var ratios = [
	[1,1],
	[9,8],
	[5,4],
	[4,3],
	[3,2],
	[5,3],
	[7,4],
	[15,8]
];
var synths = nil!ratios.size;

// GUI
var window = Window("gui", Rect());

var inputRoot;
var buttons = ratios.collect({| i |
	Button()
	.states_([
		[
			i[0].asString ++ "/" ++ i[1].asString,
			Color.black,
			Color.white
		],
		[
			i[0].asString ++ "/" ++ i[1].asString,
			Color.black,
			Color.yellow
		]
	])
});

SynthDef(\tuneSaw, {|freq=100, gate=1, out=0|
	var env = Env.asr(0.01,1,0.01).kr(2, gate) * 0.2;
	var sig = Saw.ar(freq, env);

	Out.ar(out, sig)
}).add;

window.layout = VLayout(
	StaticText().string_("Root freq:").align_(\center),
	inputRoot = TextField().string_(root.asString).align_(\center),
	HLayout(*buttons)
);

inputRoot.action = {| field |
	field.value.postln
};

window.front

)

