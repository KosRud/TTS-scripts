import * as path from 'path';
import * as net from 'node:net';

const localAppData = Deno.env.get('LOCALAPPDATA');
if (!localAppData) {
	throw new Error('LOCALAPPDATA environment variable not set');
}

Deno.copyFileSync(
	'./build/bundle.lua',
	path.join(
		localAppData,
		'Temp/TabletopSimulator/Tabletop Simulator Lua/Global.-1.lua'
	)
);

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
