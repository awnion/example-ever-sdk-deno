IMAGE_TAG := sdk-deno-test

run:
	docker build --progress=plain -t $(IMAGE_TAG) -f sdk-deno-test.Dockerfile .
	docker run --rm -ti -v $$(pwd):/workdir $(IMAGE_TAG) deno run -A --unstable "./sdk-deno-test.ts"
