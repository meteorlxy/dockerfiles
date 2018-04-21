#!/bin/bash

node /cloud9/server.js \
--listen 0.0.0.0 \
--port 80 \
--collab \
-w ${C9_WORKSPACE} \
--auth ${C9_AUTH_USER}:${C9_AUTH_PASSWORD}

"$@"
