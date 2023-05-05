export SUDO_ASKPASS="${SCRIPT_DIR}"/mac/sudo-askpass/mac-sudo-askpass.sh

echo "${SUDO_ASKPASS}" | sudo openconnect "${1}" --protocol="${2}" --authgroup="${3}" --user="${4}" --servercert="${5}" --passwd-on-stdin
