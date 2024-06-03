# Use the official NVIDIA CUDA image as a parent image
FROM node:20

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
RUN git clone https://github.com/yowsitian/sitian-silly-tavern
WORKDIR /workspace/sitian-silly-tavern
RUN export NODE_ENV=production
RUN npm i --no-audit --no-fund --quiet --omit=dev

CMD ["node", "server.js", "$@"]