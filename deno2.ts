import { TonClient } from "npm:@eversdk/core";
import { libWeb, libWebSetup } from "npm:@eversdk/lib-web";

const eversdk_wasm = await Deno.readFile(
  "./node_modules/@eversdk/lib-web/eversdk.wasm",
);
const eversdk_module = new WebAssembly.Module(eversdk_wasm);

// libWebSetup({
//   loadModule: () => new Promise((resolve) => resolve(eversdk_module)),
// });

TonClient.useBinaryLibrary(libWeb);

const client = new TonClient();

const { phrase } = await client.crypto.mnemonic_from_random({});
console.log(phrase);

console.log(
  await client.crypto.mnemonic_derive_sign_keys({
    phrase,
  }),
);

client.close();
