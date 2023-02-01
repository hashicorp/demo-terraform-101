#!/usr/bin/env sh
# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


cp /tmp/assets/webapp /usr/local/bin/
chmod +x /usr/local/bin/*
cp /tmp/assets/webapp.service /lib/systemd/system/webapp.service
service webapp start
systemctl enable webapp

