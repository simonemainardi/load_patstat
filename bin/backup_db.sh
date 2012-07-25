
#! /usr/bin/env bash
set -x

BASE=$(dirname $0)
. $BASE/upload_db.sh


# --defaults-extra-file="extraparams.cnf"

 $MYSQLDUMP   --max_allowed_packet=1G --delayed-insert=TRUE --protocol=socket --user=$USER -p$PASS --flush-logs=TRUE --default-character-set=utf8 --socket=$SOCKET --single-transaction=TRUE "patstat201204" | gzip  > ${DUMPFILE}.gz
