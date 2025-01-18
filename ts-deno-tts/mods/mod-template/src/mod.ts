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
				rectAlignment: 'UpperCenter',
				rotation: '0, 0, 0',
				position: '0 50 -100',
				scale: '1 1 1',
				childForceExpandWidth: true,
				childForceExpandHeight: false,
				childAlignment: 'UpperLeft',
				spacing: 20,
				color: 'red',
			} as any,
			children: [],
		},
	] as any);
};

onLoad = function (saveData: any) {
	broadcastToAll('ts can to tts!', { r: 1, g: 1, b: 1 });
	Array.from({ length: 5 }).forEach((value, id) => printToAll(String(id)));
	rebuildUi();
};
