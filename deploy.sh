#!/bin/bash

# Exit immediately on errors
set -e

# Pull latest code
cd /home/mohamedaly/handcut
git fetch
git reset --hard origin/main
echo "✅ Pull complete!"

echo "… Installing dependencies"

cd /home/mohamedaly/handcut/hand_cut_web
# Install dependencies
mix deps.get --only prod
echo "✅ Pull complete!"

# Optional CI steps
# mix test
# mix credo --strict

# Set mix_env so subsequent mix steps don't need to specify it
export MIX_ENV=prod

cd /home/mohamedaly/handcut/hand_cut_web
echo "… Generating assets"
mix assets.deploy
echo "✅ Pull complete!"

# Identify the currently running release
current_release=$(ls ../releases | sort -nr | head -n 1)
now_in_unix_seconds=$(date +'%s')
if [[ $current_release == '' ]]; then current_release=$now_in_unix_seconds; fi

# Create release
echo "… Generating release"
mix release --path ../releases/${now_in_unix_seconds}
echo "✅ Release ${now_in_unix_seconds} generated!"

# Get the HTTP_PORT variable from the currently running release
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
echo "⚓️ Swappin over from port ${old_port} to ${http_port}/${https_port}"


# Put env vars with the ports to forward to, and set non-conflicting node name
echo "export HTTP_PORT=${http}" >> ../releases/${now_in_unix_seconds}/releases/0.1.0/env.sh
echo "export HTTPS_PORT=${https}" >> ../releases/${now_in_unix_seconds}/releases/0.1.0/env.sh
echo "export RELEASE_NAME=${http}" >> ../releases/${now_in_unix_seconds}/releases/0.1.0/env.sh

# Set the release to the new version
rm ../env_vars || true
touch ../env_vars
echo "RELEASE=${now_in_unix_seconds}" >> ../env_vars

# Run migrations
echo "… Running ecto migrations"
cd /home/mohamedaly/handcut/hand_cut
mix ecto.migrate
cd /home/mohamedaly/handcut
echo "✅ Ecto migrations complete!"

# Boot the new version of the app
echo "… Booting new version of app"
sudo systemctl start hand_cut_web@${http}
# Wait for the new version to boot
until $(curl --output /dev/null --silent --head --fail   localhost:${http}); do
  echo 'Waiting for app to boot...'
  sleep 1
done
echo "✅ New app replied to liveness check"

# Switch forwarding of ports 443 and 80 to the ones the new app is listening on
sudo iptables -t nat -R PREROUTING 1 -p tcp --dport 80 -j REDIRECT --to-port ${http}
sudo iptables -t nat -R PREROUTING 2 -p tcp --dport 443 -j REDIRECT --to-port ${https}

# Stop the old version
sudo systemctl stop hand_cut_web@${old_port}
# Just in case the old version was started by systemd after a server
# reboot, also stop the server_reboot version
sudo systemctl stop hand_cut_web@server_reboot
echo '🚢 Deployed!'