FROM python:3.10-slim

# 依存関係のインストール
RUN apt-get update && apt-get install -y \
    gcc \
    python3-dev \
    git \
    g++ \
    cmake \
    libgl1-mesa-glx \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 作業ディレクトリを設定
WORKDIR /app
COPY ./automatic1111 /app

# Python依存関係のインストール
RUN pip install --upgrade pip
RUN pip install --upgrade huggingface_hub
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cpu
RUN pip install -r requirements.txt

# Web UIのポートを公開
EXPOSE 7860

CMD ["python", "launch.py", "--share", "--listen", "--port", "7860", "--skip-torch-cuda-test"]
