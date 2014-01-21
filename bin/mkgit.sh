#! /usr/bin/env bash
set -x

BASE=$(dirname $0)
. $BASE/upload_db.sh

mk_op_2013_09 mkgitrepo

