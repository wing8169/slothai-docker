# Use the official NVIDIA CUDA image as a parent image
FROM runpod/pytorch:2.0.1-py3.10-cuda11.8.0-devel-ubuntu22.04

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

# Add deadsnakes PPA and install Python 3.10
# RUN add-apt-repository ppa:deadsnakes/ppa && \
#     apt-get update && \
#     apt-get install -y python3.10 python3.10-venv python3.10-dev

# # Create a symlink to make python3 point to python3.10
# RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# # Install pip for Python 3.10
# RUN apt-get install -y python3-pip
RUN pip install --upgrade --force-reinstall --no-cache-dir torch==2.1.0 triton --index-url https://download.pytorch.org/whl/cu118
RUN pip install "unsloth[cu118] @ git+https://github.com/unslothai/unsloth.git"
RUN pip install python-dotenv

# Clone repo
RUN git clone https://github.com/yowsitian/unsloth_test.git

# Set the working directory to the cloned repository
WORKDIR /workspace/unsloth_test

# Run the application
# CMD ["python", "driver.py"]
# ENTRYPOINT ["tail", "-f", "/dev/null"]
# CMD ["echo", "Hello world"]