#!/bin/bash
set -eux

exec ./run --host 0.0.0.0 --voicevox_dir ./ --load_all_models
