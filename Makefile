run:
	docker build --progress=plain -t test-deno -f arm64.full-build.Dockerfile .
	docker run --rm -ti -v $$(pwd):/workdir test-deno deno run -A --unstable "./lib-deno-check.ts"
