#!/usr/bin/env bash

# Usage:
#
# . ./upload_db.sh patstat NO | tee > upload.log
#
# Requisiti: gzcat, iconv, mysql, mysqladmin
#

#set -x



LSOF=$(lsof -p $$ | grep -E "/"$(basename $0)"$")
MY_PATH=$(echo $LSOF | sed -r s/'^([^\/]+)\/'/'\/'/1 2>/dev/null)
if [ $? -ne 0 ]; then
## OSX
MY_PATH=$(echo $LSOF | sed -E s/'^([^\/]+)\/'/'\/'/1 2>/dev/null)
fi
BASE=$(dirname $MY_PATH)
. $BASE/setup.sh

echo demo is $DEMO

export SENDSQL="$MYSQL -u$USER -p$PASS $DB"

create_db() {
	$MYSQLADM -u$USER -p$PASS create $DB
}


send_ddl() {
	if [ $# -gt 1 ] ; then
		cat $DDL/$1.ddl | sed $2 | $SENDSQL ;
	else
		cat $DDL/$1.ddl | $SENDSQL ;
	fi
}

create_table() {
	# Crea la tabella
	cat $DDL/$1.ddl | $SENDSQL
}

load_table() {
	TIME=$(date '+%F %T %Z')
	INTIME=$(date +%s)

	sleep 1

	if [ ! -d $ZIPARCHIVE/$RELEASE/$1 ]; then
		echo ERROR: path $ZIPARCHIVE/$RELEASE/$1 does not exist
		exit
	fi

	create_table $3

	# FLUSH TABLES
	echo FLUSH TABLES \; | $SENDSQL

	# This removes all use of indexes for the table.
	# An option value of 0 disables updates to all indexes, which can be used to get faster inserts.
	$MYISAMCHK  --keys-used=0 -rq $MYSQLVARPATH/$DB/$3.MYI

	echo ALTER TABLE $3 DISABLE KEYS\; | $SENDSQL ;
	echo TRUNCATE TABLE $3 \; | $SENDSQL ;


	echo $TIME Loading data in $3 from $2 files

	# all files containing data for the current table
	EXPECTED_ROWCOUNT=0
	# some rows are buggy, that is, they contain a backslash just before the last double quote
	# e.g.,
	# 6597821,"US",664004,"CellTech Power, Inc.","Westboro,MA,\"
	# so we must fix this and we use sed regexp replacement
	# the original sed expr is
	# sed -e 's/\\\("[^\"]$\)/\1/g'
	# but we've to add some extra quotes in order to put the command in a shell variable
	SED_FIX_1=`echo sed -e 's/\\\\\\("[^\"]$\\)/\1/g'`

	# other rows are bugged as well since the cotain a backslash just before some double quote
	# separating different columns
	# e.g., 
	# 8638854,"",4318,"BROTHER KOGYO KABUSHIKI KAISHA\",""
	# so again we've to fix it using sed. The original sed expr used is:
	#  sed -e 's/\\\(",\"\)/\1/g'
	# the escaped expression is
	SED_FIX_2=`echo sed -e 's/\\\\\\(",\"\\)/\1/g'`

	for ZIPPEDFILE in `find $LOADPATH/$RELEASE/$1 -name "$2_part*\.zip" | sort`
	do
	    echo loading part file $ZIPPEDFILE
	    UNZIPPEDFILE=/dev/shm/`basename $ZIPPEDFILE`.txt

            if [ $DEMO == 'YES' ]
	    then
                funzip $ZIPPEDFILE | head -n 10000 | $SED_FIX_1 | $SED_FIX_2 > $UNZIPPEDFILE
            else
                funzip $ZIPPEDFILE | $SED_FIX_1 | $SED_FIX_2 > $UNZIPPEDFILE
	    fi
	    let "EXPECTED_ROWCOUNT = EXPECTED_ROWCOUNT + `awk 'END { print NR }' $UNZIPPEDFILE` - 1"
#	    echo $EXPECTED_ROWCOUNT

	    $SENDSQL <<EOF
               set autocommit = 0;
               set unique_checks = 0;
               set foreign_key_checks = 0;
               LOAD DATA LOCAL INFILE "$UNZIPPEDFILE"
               INTO TABLE $3 FIELDS TERMINATED BY ","
               OPTIONALLY ENCLOSED BY '"'
               LINES TERMINATED BY '\r\n'
               IGNORE 1 LINES;
               commit;
               SHOW WARNINGS;
EOF
	    rm -rf $UNZIPPEDFILE
	done

	echo ALTER TABLE $3 ENABLE KEYS \; | $SENDSQL ;

	# If you intend only to read from the table in the future, use myisampack to compress it.
	$MYISAMPACK $MYSQLVARPATH/$DB/$3.MYI

	# Re-create the indexes
	$MYISAMCHK  -rq $MYSQLVARPATH/$DB/$3.MYI

	# FLUSH TABLES
	echo FLUSH TABLES \; | $SENDSQL

	echo "no. of rows inserted into $3: `echo SELECT COUNT\(\*\) FROM $3 | $SENDSQL` (expected: $EXPECTED_ROWCOUNT)"

	OUTTIME=$(date +%s)
	echo " $OUTTIME - $INTIME = "  $(( $OUTTIME - $INTIME )) sec " = " $(( ( $OUTTIME - $INTIME ) / 60 )) min

#	read -p 'waiting...'
}


mk_op_2014a() {
OP=$1
$OP Data tls201   tls201_appln
$OP Data tls202   tls202_appln_title
$OP Data tls204   tls204_appln_prior
$OP Data tls205   tls205_tech_rel
$OP Data tls206   tls206_person
$OP Data tls207   tls207_pers_appln
$OP Data tls208   tls208_doc_std_nms
$OP Data tls209   tls209_appln_ipc
$OP Data tls210   tls210_appln_n_cls
$OP Data tls211   tls211_pat_publn
$OP Data tls212   tls212_citation
$OP Data tls214   tls214_npl_publn
$OP Data tls215   tls215_citn_categ
$OP Data tls216   tls216_appln_contn
$OP Data tls218   tls218_docdb_fam
$OP Data tls219   tls219_inpadoc_fam
$OP Data tls222   tls222_appln_jp_class
$OP Data tls223   tls223_appln_docus
$OP Data tls224   tls224_appln_cpc
$OP Data tls226   tls226_person_orig
$OP Data tls227   tls227_pers_publn
$OP Data tls801   tls801_country
$OP Data tls802   tls802_legal_event_code
$OP Data tls901   tls901_techn_field_ipc

$OP Data tls203   tls203_appln_abstr
$OP Data tls221   tls221_inpadoc_prs
}


