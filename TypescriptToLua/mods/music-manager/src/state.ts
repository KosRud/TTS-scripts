type ResourceConfig = {
	max: number;
	current: number;
};

type State = {
	config: {
		uiQuality: number;
		resources: Record<string, ResourceConfig>;
	};
	isOpen: boolean;
	isFlipped: boolean;
};

declare global {
	let state: State;
}

state = {
	config: {
		uiQuality: 3,
		resources: {
			'spell slot (level 1)': { max: 4, current: 4 },
			'spell slot (level 2)': { max: 3, current: 3 },
			'spell slot (level 3)': { max: 2, current: 2 },
		},
	},
	isOpen: true,
	isFlipped: false,
};
