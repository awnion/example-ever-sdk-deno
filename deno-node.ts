import { TonClient } from "npm:@eversdk/core";
import { libNode } from "npm:@eversdk/lib-node";

TonClient.useBinaryLibrary(libNode);

const client = new TonClient();
const { phrase } = await client.crypto.mnemonic_from_random({});
console.log(phrase);
console.log(await client.crypto.mnemonic_derive_sign_keys({ phrase }));
client.close();
