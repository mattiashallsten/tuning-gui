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
var output = 0;

// GUI
var window = Window("gui", Rect());

var inputRoot, inputOutput;
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
	HLayout(
		VLayout(
			StaticText().string_("Root freq:").align_(\center),
			inputRoot = TextField().string_(root.asString).align_(\center),
		),
		VLayout(
			StaticText().string_("Output:").align_(\center),
			inputOutput = PopUpMenu().items_(["0", "1"])
		)
	),
	HLayout(*buttons)
);

inputRoot.action = {| field |
	root = field.value.asInteger
};
inputOutput.action = {| field |
	output = field.value.asInteger
};

buttons.do{| item, i |
	item.action = {| button |
		var state = button.value;

		switch(state,
			0, {
				if(synths[i].notNil, {
					synths[i].set(\gate,0)})
			},
			1, {
				synths[i] = Synth(\tuneSaw, [
					\freq, root * ratios[i][0] / ratios[i][1],
					\out, output
				])
			},
		)

	}
};

window.front
)