#! /usr/bin/env bash
set -x

./upload_db.sh

send_ddl CREATE_DB "\"/%db/$DB\""

