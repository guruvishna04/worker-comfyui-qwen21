FROM runpod/worker-comfyui:5.10.0-base

# Upgrade ComfyUI to a version with Qwen Image 2.1 support
# (TextEncodeQwenImage21 / krea2 CLIP types). v0.34.0 lacks these nodes.
RUN cd /comfyui && \
    git fetch origin master --depth 1 && \
    git reset --hard origin/master && \
    /opt/venv/bin/pip install -r requirements.txt \
        "transformers>=4.50.3,<5" "huggingface-hub<1.0"

# Models live on the attached network volume (models/unet|clip|vae),
# already handled by the base image's extra_model_paths.yaml.
