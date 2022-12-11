# example-ever-sdk-deno

## Install DENO

```bash
brew install deno
# or
cargo install deno
```

## Run

```bash
deno run -A deno.ts
```

This one should work but doesn't because @eversdk/lib-web is not a real node module and work only in browser.

```bash
npm i @eversdk/lib-web # just for eversdk.wasm or you can download it manually
deno run -A deno-custom-wasm.ts
```

Manually try to load and we get new error.

```text
error: Uncaught ReferenceError: init is not defined
    await init(wasmModule);
```
