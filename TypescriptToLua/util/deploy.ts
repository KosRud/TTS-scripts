import * as path from 'jsr:@std/path';

const localAppData = Deno.env.get('LOCALAPPDATA');
if (!localAppData) {
	throw new Error('LOCALAPPDATA environment variable not set');
}

const buildPath = Deno.args[0];

for await (const dirEntry of Deno.readDir(buildPath)) {
	if (!dirEntry.isFile) {
		continue;
	}
	Deno.copyFileSync(
		path.join(buildPath, dirEntry.name),
		path.join(
			localAppData,
			'Temp/TabletopSimulator/Tabletop Simulator Lua',
			dirEntry.name
		)
	);
}

// const conn = await Deno.connect({ hostname: '127.0.0.1', port: 39999 });
// const message = JSON.stringify({
// 	messageID: 1,
// 	scriptStates: [
// 		{
// 			name: 'Global',
// 			guid: '-1',
// 			script: '',
// 			ui: '',
// 		},
// 		{
// 			name: 'Block Rectangle',
// 			guid: 'a0b2d5',
// 			script: '',
// 		},
// 	],
// });
// await conn.write(new TextEncoder().encode(message));
// conn.close();
