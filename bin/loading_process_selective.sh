#! /usr/bin/env bash
set -x

BASE=$(dirname $0)
. $BASE/upload_db.sh

# create_db $DB

TABLE=${2-NOTABLE}

#mk_op wc_file
mk_op_selective load_table $TABLE
# send_ddl TLS206_PERSON_FULL 
#mk_op count_table

