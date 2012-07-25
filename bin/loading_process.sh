#! /usr/bin/env bash
set -x

BASE=$(dirname $0)
. $BASE/upload_db.sh

create_db $DB

mk_op load_table
mk_tls206_ascii
mk_op count_table

