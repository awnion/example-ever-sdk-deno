# example-ever-sdk-deno

## Install DENO

```bash
brew install deno
# or
cargo install deno
```

## Run

### Try naive

```bash
deno run -A deno.ts
```

This one should work but doesn't because @eversdk/lib-web is not a real node module and work only in browser.

### Try load WASM manually

```bash
npm i @eversdk/lib-web # just for eversdk.wasm or you can download it manually
deno run -A deno-custom-wasm.ts
```

Manually try to load and we get new error.

```log
error: Uncaught ReferenceError: init is not defined
    await init(wasmModule);
```

### Try load as `lib-node` instead of `lib-web`

```bash
# current deno is either ubuntu 20.04 or debian11
# we make custom deno + ubuntu 22.04
docker buildx build -t deno22 .
# here you need to have $HOME/.tonlabs/binaries/1/eversdk.node binary for ubuntu 22.04
docker run --rm -ti -v "`pwd`/deno-node.ts:/deno-node.ts" -v "$HOME/.tonlabs/binaries/1/eversdk.node:/root/.tonlabs/binaries/1/eversdk.node" deno22 deno run -A --unstable deno-node.ts
```

We get an error:

```log
error: Uncaught TypeError: /root/.tonlabs/binaries/1/eversdk.node: undefined symbol: SSL_CTX_free
    at Object.Module._extensions..node (deno:ext/node/02_require.js:794:26)
    at Module.load (deno:ext/node/02_require.js:645:34)
    at Function.Module._load (deno:ext/node/02_require.js:502:14)
    at Module.require (deno:ext/node/02_require.js:667:21)
    at require (deno:ext/node/02_require.js:807:18)
    at loadAddon (file:///deno-dir/npm/registry.npmjs.org/@eversdk/lib-node/1.39.0/index.js:36:12)
    at libNode (file:///deno-dir/npm/registry.npmjs.org/@eversdk/lib-node/1.39.0/index.js:41:32)
    at new CommonBinaryBridge (file:///deno-dir/npm/registry.npmjs.org/@eversdk/core/1.39.0/dist/bin.js:79:9)
    at useLibrary (file:///deno-dir/npm/registry.npmjs.org/@eversdk/core/1.39.0/dist/bin.js:36:18)
    at Function.useBinaryLibrary (file:///deno-dir/npm/registry.npmjs.org/@eversdk/core/1.39.0/dist/client.js:60:30)
```

Manually building eversdk.node in the target container with node and deno installed gives the same error.
