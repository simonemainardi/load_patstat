#! /usr/bin/env bash
set -x

BASE=$(dirname $0)
. $BASE/upload_db.sh

mk_tls206_ascii
mk_op count_table

