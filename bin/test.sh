#! /usr/bin/env bash
set -x

BASE=$(dirname $0)
. $BASE/upload_db.sh

merge_tables PATSTAT tls201    4         TLS201_APPLN                 YES            NO                      CSV

