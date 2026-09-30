# Custom serverless image: worker-comfyui + ComfyUI 0.38.0

The stock `runpod/worker-comfyui` image bundles ComfyUI `0.34.0`, which lacks
`TextEncodeQwenImage21` / `krea2` support. This Dockerfile upgrades ComfyUI to
`master` (0.38.x) so the Qwen Image 2.1 models (Noct Q) and Krea-2 STRONG run.

Models are NOT baked in — they stay on the network volume
(`models/unet|clip|vae`), which the base image already maps.

## Deploy (two options)

### A. RunPod Hub GitHub integration (no local Docker)
1. Put this `Dockerfile` at the root of a GitHub repo.
2. RunPod console → Hub → "Create repo" (serverless) → connect GitHub →
   select the repo → set GPU `ADA_24`, attach network volume `j4gprq93es`.
3. RunPod builds the image in the cloud and creates the endpoint.

### B. Local Docker (if you install Docker)
```
docker build --platform linux/amd64 -t yourrepo/worker-comfyui-qwen21 .
docker push yourrepo/worker-comfyui-qwen21
```
then create the endpoint from that image.

## Notes
- The endpoint must be in `US-TX-3` (where network volume `j4gprq93es` lives).
- GPU `ADA_24` (L4) is confirmed available in US-TX-3.
- After deploy, models resolve from the volume exactly as the pod does.
