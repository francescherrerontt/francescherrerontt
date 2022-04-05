#!/bin/bash -eux

if [ -f /etc/os-release ]; then
  DISTRIBUTION=$(cat /etc/os-release |  awk -F'='  '/^ID=/ {print $2}' | tr -d '\"')
  DISTRIBUTION_VERSION=$(cat /etc/os-release |  awk -F'='  '/^VERSION_ID=/ {print $2}' | tr -d '\"')
  DISTRIBUTION_MAJOR_VERSION=$(echo $DISTRIBUTION_VERSION | cut -d. -f1)
elif [ -f /etc/redhat-release ]; then
  DISTRIBUTION=$(cat /etc/redhat-release | cut -d' ' -f1 |  tr '[:upper:]' '[:lower:]')
  DISTRIBUTION_VERSION=$(cat /etc/redhat-release | cut -d' ' -f3)
  DISTRIBUTION_MAJOR_VERSION=$(echo $DISTRIBUTION_VERSION | cut -d. -f1)
else
  echo "[ERROR] Unknown Linux distribution"
  exit 1
fi

echo "DISTRIBUTION: $DISTRIBUTION"
echo "DISTRIBUTION_VERSION: $DISTRIBUTION_VERSION"
echo "DISTRIBUTION_MAJOR_VERSION: $DISTRIBUTION_MAJOR_VERSION"
case ${DISTRIBUTION} in
  "ubuntu")
     apt-get clean
        ;;
   "centos" | "rhel")
       yum clean all
       rm -rf /var/cache/yum
   ;;
     *)
         echo "[ERROR] Unkown OS (${DISTRIBUTION}-${DISTRIBUTION_MAJOR_VERSION})"
     exit 1
  ;;
esac

# Add `sync` so Packer doesn't quit too early, before the large file is deleted.
sync