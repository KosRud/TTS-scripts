declare global {
	let onLoad: (saveData: any) => void;
	let rebuildUi: () => void;
	const myObj: GObject;
}
const myObj = self as unknown as GObject;

rebuildUi = function () {
	myObj.UI.setXmlTable([
		{
			tag: 'VerticalLayout',
			attributes: {
				height: 400,
				width: 400,
				childForceExpandWidth: true,
				childForceExpandHeight: false,
				childAlignment: 'UpperLeft',
				spacing: 20,
				color: 'white',
			} as any,
			children: [],
		},
	] as any);
};

onLoad = function (saveData: any) {
	broadcastToAll('ts can to tts!', { r: 1, g: 1, b: 1 });
	rebuildUi();
};
