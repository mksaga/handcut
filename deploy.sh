#!/bin/bash

# Exit immediately on errors
set -e

# Color setup
RED='\033[0;31m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

color_prompt () {
    echo -en "${PURPLE}"
    echo $1
    echo -en "${NC}"
}

# Pull latest code
cd /home/mohamedaly/handcut
git fetch
git reset --hard origin/main
color_prompt "✅ Pull complete!"

cd /home/mohamedaly/handcut/hand_cut
source .env.prod
cd /home/mohamedaly/handcut/hand_cut_web
source .env.prod
color_prompt "🌲 Environment variables loaded!"

color_prompt "… Installing dependencies"

cd /home/mohamedaly/handcut/hand_cut_web
# Install dependencies
mix deps.get --only prod
color_prompt "✅ Dependencies installed!"

# Optional CI steps
# mix test
# mix credo --strict

# Set mix_env so subsequent mix steps don't need to specify it
export MIX_ENV=prod

cd /home/mohamedaly/handcut/hand_cut_web
color_prompt "… Generating assets" 
mix assets.deploy
color_prompt "✅ Assets generated!"

# Identify the currently running release
current_release=$(ls ../releases | sort -nr | head -n 1)
color_prompt "Current release: ${current_release}"
now_in_unix_seconds=$(date +'%s')
if [[ $current_release == '' ]]; then current_release=$now_in_unix_seconds; fi

# Create release
color_prompt "… Generating release"
pwd
mix release --path ../releases/${now_in_unix_seconds}
color_prompt "✅ Release ${now_in_unix_seconds} generated!"

# Get the HTTP_PORT variable from the currently running release
cat ../releases/${current_release}/releases/0.1.0/env.sh
source ../releases/${current_release}/releases/0.1.0/env.sh

if [[ $HTTP_PORT == '4000' ]]
then
  http=4001
  https=4041
  old_port=4000
else
  http=4000
  https=4040
  old_port=4001
fi
color_prompt "⚓️ Swappin over from port ${old_port} to ${http}/${https}"


# Put env vars with the ports to forward to, and set non-conflicting node name
echo "export HTTP_PORT=${http}" >> ../releases/${now_in_unix_seconds}/releases/0.1.0/env.sh
echo "export HTTPS_PORT=${https}" >> ../releases/${now_in_unix_seconds}/releases/0.1.0/env.sh
echo "export RELEASE_NAME=${http}" >> ../releases/${now_in_unix_seconds}/releases/0.1.0/env.sh

# Copy env variables into release
cat .env.prod >> ../releases/${now_in_unix_seconds}/releases/0.1.0/env.sh
cat ../hand_cut/.env.prod >> ../releases/${now_in_unix_seconds}/releases/0.1.0/env.sh

# Set the release to the new version
pwd
rm ../env_vars || true
touch ../env_vars
echo "RELEASE=${now_in_unix_seconds}" >> ../env_vars
color_prompt "Env vars created 👍"

# Run migrations
# color_prompt "… Running ecto migrations"
# cd /home/mohamedaly/handcut/hand_cut
# MIX_ENV=prod mix ecto.migrate
# cd /home/mohamedaly/handcut
# color_prompt "✅ Ecto migrations complete!"

# Boot the new version of the app
color_prompt "… Booting new version of app"
sudo systemctl start hand_cut_web@${http}
# Wait for the new version to boot
until $(curl --output /dev/null --silent --head --fail   localhost:${http}); do
  echo 'Waiting for app to boot...'
  sleep 1
done
color_prompt "✅ New app replied to liveness check"

# Switch forwarding of ports 443 and 80 to the ones the new app is listening on
sudo iptables -t nat -R PREROUTING 1 -p tcp --dport 80 -j REDIRECT --to-port ${http}
sudo iptables -t nat -R PREROUTING 2 -p tcp --dport 443 -j REDIRECT --to-port ${https}

# Stop the old version
sudo systemctl stop hand_cut_web@${old_port}
# Just in case the old version was started by systemd after a server
# reboot, also stop the server_reboot version
sudo systemctl stop hand_cut_web@server_reboot
color_prompt '🚢 Deployed!'