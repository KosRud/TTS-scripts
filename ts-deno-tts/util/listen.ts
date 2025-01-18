const srv = Deno.listen({ hostname: '0.0.0.0', port: 39998 });
for await (const conn of srv) {
	handleConnection(conn);
}

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
