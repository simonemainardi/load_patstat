#! /usr/bin/env bash
#set -x

BASE=$(dirname $0)
. $BASE/upload_db.sh

create_db $DB
mk_op_2014a load_table

