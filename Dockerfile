FROM ubuntu:22.04

WORKDIR /opt/voicevox_engine

# ランタイムに必要な依存関係をインストール
RUN apt-get update && \
    apt-get install -y \
    curl \
    unzip \
    python3 \
    python3-pip \
    ffmpeg \
    libsndfile1 \
    && apt-get clean

# VOICEVOX ENGINE バイナリダウンロード
RUN curl -LO https://github.com/VOICEVOX/voicevox_engine/releases/download/0.24.1/voicevox_engine-linux-cpu-0.24.1.zip && \
    unzip voicevox_engine-linux-cpu-0.24.1.zip && \
    rm voicevox_engine-linux-cpu-0.24.1.zip

# 冥鳴ひまりのモデルのみ取得
RUN mkdir -p voicevox_core/model && \
    cd voicevox_core/model && \
    curl -LO https://github.com/VOICEVOX/voicevox_resource/releases/download/0.24.1/model/metas.json && \
    curl -LO https://github.com/VOICEVOX/voicevox_resource/releases/download/0.24.1/model/meina_himari/onnx.onnx && \
    curl -LO https://github.com/VOICEVOX/voicevox_resource/releases/download/0.24.1/model/meina_himari/model.yaml

# ポート開放
EXPOSE 50021

# スタートスクリプト
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
