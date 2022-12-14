import { TonClient } from "npm:@eversdk/core";
// require npm i @eversdk/lib-web
import { libWeb, libWebSetup } from "./node_modules/@eversdk/lib-web/index.js";

// require npm i @eversdk/lib-web
libWebSetup({
  disableSeparateWorker: true,
  binaryURL: new URL(
    "./node_modules/@eversdk/lib-web/eversdk.wasm",
    import.meta.url,
  ),
});

TonClient.useBinaryLibrary(libWeb);
// ------------------------^^^^^^
// here linter will complain but it's OK

const client = new TonClient();
const { phrase } = await client.crypto.mnemonic_from_random({});
console.log(phrase);
console.log(await client.crypto.mnemonic_derive_sign_keys({ phrase }));
client.close();
