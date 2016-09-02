#!/bin/sh

REXRAY_CONFIG=/etc/rexray/config.yml

mkdir -p /etc/rexray

echo "rexray:
  storageDrivers:
  - ec2
modules:
    default-admin:
      type:     admin
      desc:     The default admin module.
      host:     tcp://:7979
      disabled: false
    default-docker:
      type:     docker
      desc:     The default docker module.
      host:     unix:///run/docker/plugins/rexray.sock
      spec:     /etc/docker/plugins/rexray.spec
      disabled: false
aws:
  accessKey: $AWS_ACCESS_KEY_ID
  secretKey: $AWS_SECRET_ACCESS_KEY
" > $REXRAY_CONFIG

echo Rexray config to use:
cat $REXRAY_CONFIG

/usr/bin/rexray version
/usr/bin/rexray start -f --logLevel=info --host=tcp://:7979
