#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 <<-EOSQL
	CREATE USER web_server WITH SUPERUSER PASSWORD 'jerry';
	CREATE DATABASE jerry_dev OWNER web_server;
	CREATE USER jerry_test WITH SUPERUSER PASSWORD 'jerry_test';
  CREATE DATABASE jerry_test OWNER jerry_test;

	CREATE DATABASE telematics_dev OWNER web_server;
	CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

	CREATE DATABASE garage_dev OWNER web_server;

	CREATE DATABASE content_dev OWNER web_server;
EOSQL
