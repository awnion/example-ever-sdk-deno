import { libDeno } from "https://raw.githubusercontent.com/tonlabs/ever-sdk-js/SDK-4838-deno-binding/packages/lib-deno/mod.ts";
import { TonClient } from "https://raw.githubusercontent.com/tonlabs/ever-sdk-js/SDK-4838-deno-binding/packages/lib-deno/example/deps.ts";

TonClient.useBinaryLibrary(libDeno);

const client = new TonClient();
console.log(">>>", (await client.client.version()).version);
console.log(
  ">>>",
  JSON.stringify(await client.crypto.generate_random_sign_keys()),
);
client.close();
