#! /usr/bin/env bash
set -x

BASE=$(dirname $0)
. $BASE/upload_db.sh

create_db $DB

mk_op_2013_09 load_table
mk_tls206_ascii
mk_op_2013_09 count_table

