declare global {
	let state: {};
	let onLoad: (saveData: any) => void;
}

state = {};

onLoad = function (saveData: any) {
	broadcastToAll('ts can to tts!', { r: 1, g: 1, b: 1 });
};
