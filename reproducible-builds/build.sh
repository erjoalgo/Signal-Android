#!/bin/bash -x

set -euo pipefail

sudo -u ${USER} docker build -t signal-android .

# Go back up to the root of the project
cd ..

# Build using the Docker environment
sudo -u ${USER} docker run --rm -v $(pwd):/project -w /project signal-android ./gradlew clean assemblePlayProdRelease

# Verify the APKs
python3 apkdiff/apkdiff.py app/build/outputs/apks/project-release-unsigned.apk path/to/SignalFromPlay.apk
