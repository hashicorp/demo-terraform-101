#!/usr/bin/env sh
# Copyright IBM Corp. 2017, 2026


cp /tmp/assets/webapp /usr/local/bin/
chmod +x /usr/local/bin/*
cp /tmp/assets/webapp.service /lib/systemd/system/webapp.service
service webapp start
systemctl enable webapp

