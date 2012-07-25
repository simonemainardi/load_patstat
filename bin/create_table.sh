#! /usr/bin/env bash
set -x

BASE=$(dirname $0)
. $BASE/upload_db.sh

create_table $1


