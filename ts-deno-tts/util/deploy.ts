import * as path from 'jsr:@std/path';

const localAppData = Deno.env.get('LOCALAPPDATA');
if (!localAppData) {
	throw new Error('LOCALAPPDATA environment variable not set');
}

const buildPath = Deno.args[0];

const scriptStates = [];

const srv = Deno.listen({ hostname: '0.0.0.0', port: 39998 });

async function handleConnection(conn: Deno.Conn) {
	try {
		const buf = new Uint8Array(1024);

		while (true) {
			const bytesRead = await conn.read(buf);
			if (bytesRead == null) break;
			const data = new TextDecoder().decode(buf.subarray(0, bytesRead));

			try {
				const jsonData = JSON.parse(data);
				console.log('Received JSON:', jsonData);
			} catch (e) {
				console.log('received invalid JSON!');
			}
		}
	} catch (error) {
		console.error('Connection error:', error);
	} finally {
		conn.close();
	}
}

for await (const dirEntry of Deno.readDir(buildPath)) {
	if (!dirEntry.isFile) {
		continue;
	}
	const groups = /(?<name>[^.]+)\.(?<guid>[^.]+)\.(?<extension>[^.]+)/.exec(
		dirEntry.name
	)?.groups;
	if (!groups) {
		throw new Error(`invalid file name: ${dirEntry.name}`);
	}
	const { name, guid } = groups;
	scriptStates.push({
		name,
		guid,
		script: Deno.readTextFileSync(path.join(buildPath, dirEntry.name)),
	});
	// Deno.copyFileSync(
	// 	path.join(buildPath, dirEntry.name),
	// 	path.join(
	// 		localAppData,
	// 		'Temp/TabletopSimulator/Tabletop Simulator Lua',
	// 		dirEntry.name
	// 	)
	// );
}

setTimeout(() => {
	srv.close();
}, 5000);

for await (const conn of srv) {
	handleConnection(conn);
}

const conn = await Deno.connect({ hostname: '127.0.0.1', port: 39999 });
const message = JSON.stringify({
	messageID: 1,
	scriptStates,
});
await conn.write(new TextEncoder().encode(message));
conn.close();
