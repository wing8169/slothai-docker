# Use the official NVIDIA CUDA image as a parent image
FROM nvidia/cuda:12.1.0-runtime-ubuntu22.04

# Update the package list and install necessary tools
RUN apt-get update --yes && \
    apt-get install --yes --no-install-recommends \
    wget \
    bzip2 \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the working directory
WORKDIR /workspace

# Update PATH environment variable
ENV PATH=/opt/conda/bin:$PATH

# Start conda
RUN conda create --name unsloth_env python=3.10
RUN conda activate unsloth_env

# Install dependencies
RUN conda install pytorch-cuda=12.1 pytorch cudatoolkit xformers -c pytorch -c nvidia -c xformers
RUN pip install "unsloth[colab-new] @ git+https://github.com/unslothai/unsloth.git"
RUN pip install --no-deps trl peft accelerate bitsandbytes

# Clone repo
RUN git clone https://github.com/yowsitian/unsloth_test.git

# Set the working directory to the cloned repository
WORKDIR /workspace/unsloth_test

# Run the application
CMD ["python", "driver.py"]