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