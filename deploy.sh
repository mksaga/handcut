#!/bin/bash

# Exit immediately on errors
set -e

# Pull latest code
cd /home/mohamedaly/handcut
git fetch
git reset --hard origin/main

# Install dependencies
mix deps.get --only prod

# Optional CI steps
# mix test
# mix credo --strict

# Set mix_env so subsequent mix steps don't need to specify it
export MIX_ENV=prod

# Identify the currently running release
current_release=$(ls ../releases | sort -nr | head -n 1)
now_in_unix_seconds=$(date +'%s')
if [[ $current_release == '' ]]; then current_release=$now_in_unix_seconds; fi

# Create release
mix release --path ../releases/${now_in_unix_seconds}