import { TonClient } from "npm:@eversdk/core";
import { libWeb } from "npm:@eversdk/lib-web@1.44.1";

TonClient.useBinaryLibrary(libWeb);

const client = new TonClient();
const { phrase } = await client.crypto.mnemonic_from_random({});
console.log(phrase);
console.log(await client.crypto.mnemonic_derive_sign_keys({ phrase }));
client.close();
