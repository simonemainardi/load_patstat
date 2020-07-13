#!/usr/bin/env bash

# A POSIX variable
OPTIND=1         # Reset in case getopts has been used previously in the shell.


# Initialize our own variables:
MYSQLDATAPATH="/var/lib/mysql"
ZIPFILESPATH=./data
LOGPATH=./logs
verbose=0
DEMO=0
ENGINE=myisam
USER=
PASS=
HOST=
DB=


function show_help() {
    echo "Usage: [-v] [-t] -u mysql_user -p mysql_pass -h mysql_host -d mysql_dbname -z patstat_zips_dir"
    echo "  -v: be verbose"
    echo "  -t: load small chunks of data for testing purposes"
    echo "  -z: directory containing patstat zipped files shipped in DVDs (defaults to $ZIPFILESPATH)"
    echo "  -o: output and error logs directory (defaults to $LOGPATH)"
    echo "  -m: mysql data path (defaults to $MYSQLDATAPATH)"
    echo "  -e: mysql engine (defaults to $ENGINE)"
}

while getopts "?vto:u:p:d:h:z:m:e:" opt; do
    case "$opt" in
    \?)
        show_help
	exit 0
        ;;
    v)  verbose=1
        ;;
    o)  LOGPATH=$OPTARG
        ;;
    t)  DEMO=1
        ;;
    u)  USER=$OPTARG
	;;
    p)  PASS=$OPTARG
	;;
    h)  HOST=$OPTARG
	;;
    d)  DB=$OPTARG
	;;
    z)  ZIPFILESPATH=$OPTARG
	;;
    m)  MYSQLDATAPATH=$OPTARG
	;;
    e)  ENGINE=$(echo $OPTARG | tr  '[:upper:]' '[:lower:]')
	;;
    esac
done


shift $((OPTIND-1))

[ "$1" = "--" ] && shift

if [[ -z $USER ]] || [[ -z $PASS ]] || [[ -z $HOST ]] || [[ -z $DB ]] || [[ -z $ZIPFILESPATH ]]
then
     show_help
     exit 1
fi

if [[ ! $verbose -eq 0 ]]
then
    echo "user: $USER pass: $PASS host: $HOST database: $DB"
    echo "zipped files path: $ZIPFILESPATH"
    echo "verbose=$verbose, test=$DEMO leftovers: $@"
fi

if [ ! -d $ZIPFILESPATH ]; then
    echo ERROR: path $ZIPFILESPATH does not exist
    exit
fi

SENDSQL="mysql -vv --show-warnings --local-infile -u$USER -p$PASS -h$HOST $DB"

function create_db() {
    ./tools/create_schema.sh $DB $ENGINE | mysql -vv --show-warnings -u$USER -p$PASS -h$HOST
    echo FLUSH TABLES \; | $SENDSQL
}

load_table() {
	TIME=$(date '+%F %T %Z')
	INTIME=$(date +%s)

	# This removes all use of indexes for the table.
	# An option value of 0 disables updates to all indexes, which can be used to get faster inserts.
	echo TRUNCATE TABLE $1 \; | $SENDSQL
        if [[ $ENGINE == "myisam" ]]; then
	    echo ALTER TABLE $1 DISABLE KEYS\; | $SENDSQL ;
        fi

        if [[ $ENGINE == "myisam" ]]; then
	    myisamchk  --keys-used=0 -rqp $MYSQLDATAPATH/$DB/$1*.MYI
        fi

	echo $TIME Loading data in $1 from $3 files

	# all files containing data for the current table
	EXPECTED_ROWCOUNT=0

	prefix=$(echo $1 | cut -d'_' -f 1)  # grab only the prefix, e.g. tls201, from the full table name
	for ZIPPEDFILE in `find $ZIPFILESPATH -name "$prefix\_part*\.zip" | sort`
	do
	    echo loading part file $ZIPPEDFILE

	    UNZIPPEDFILE=/dev/shm/`basename $ZIPPEDFILE`.txt

            if [ $DEMO -eq 1 ]
	    then
                funzip $ZIPPEDFILE | head -n 10000 > $UNZIPPEDFILE
            else
                funzip $ZIPPEDFILE > $UNZIPPEDFILE
	    fi

	    let "EXPECTED_ROWCOUNT = EXPECTED_ROWCOUNT + `awk 'END { print NR }' $UNZIPPEDFILE` - 1"
#	    echo $EXPECTED_ROWCOUNT

	    $SENDSQL <<EOF
               set autocommit = 0;
               set unique_checks = 0;
               set foreign_key_checks = 0;
               LOAD DATA LOCAL INFILE "$UNZIPPEDFILE"
               INTO TABLE $1
               CHARACTER SET 'utf8mb4'
               FIELDS TERMINATED BY ","
               OPTIONALLY ENCLOSED BY '"'
               ESCAPED BY ''
               LINES TERMINATED BY '\r\n'
               IGNORE 1 LINES;
               commit;
               SHOW WARNINGS;
EOF
	    rm -rf $UNZIPPEDFILE
	done

        if [[ $ENGINE == "myisam" ]]; then
	    echo ALTER TABLE $1 ENABLE KEYS \; | $SENDSQL ;
        fi

        if [[ $ENGINE == "myisam" ]]; then
	    # If you intend only to read from the table in the future, use myisampack to compress it.
	    # only if it was not partitioned
	    echo "compressing"
	    myisampack $MYSQLDATAPATH/$DB/$1.MYI

	    # Re-create the indexes
	    myisamchk  -rqp --sort-buffer-size=2G $MYSQLDATAPATH/$DB/$1*.MYI
        fi

	# FLUSH TABLES
	echo FLUSH TABLES \; | $SENDSQL

	echo "no. of rows inserted into $1: `echo SELECT COUNT\(\*\) FROM $1 | $SENDSQL` (expected: $EXPECTED_ROWCOUNT)"

	OUTTIME=$(date +%s)
	echo " $OUTTIME - $INTIME = "  $(( $OUTTIME - $INTIME )) sec " = " $(( ( $OUTTIME - $INTIME ) / 60 )) min

#	read -p 'waiting...'
}

function main(){
    # creates an empty database schema
    create_db

    # loads official patstat tables
    load_table tls201_appln
    load_table tls202_appln_title
    load_table tls204_appln_prior
    load_table tls205_tech_rel
    load_table tls206_person
    load_table tls904_nuts
    load_table tls906_person  # this is person table with harmonized names
    load_table tls207_pers_appln
    load_table tls209_appln_ipc
    load_table tls210_appln_n_cls
    load_table tls211_pat_publn
    load_table tls212_citation
    load_table tls214_npl_publn
    load_table tls215_citn_categ
    load_table tls216_appln_contn
    load_table tls222_appln_jp_class
    load_table tls223_appln_docus
    load_table tls224_appln_cpc
    load_table tls225_docdb_fam_cpc
    load_table tls226_person_orig
    load_table tls227_pers_publn
    load_table tls228_docdb_fam_citn
    load_table tls229_appln_nace2
    load_table tls230_appln_techn_field
    load_table tls801_country
    load_table tls803_legal_event_code
    load_table tls901_techn_field_ipc
    load_table tls902_ipc_nace2
    load_table tls203_appln_abstr
    load_table tls231_inpadoc_legal_event

    # finally, prints out some statistics on loaded tables
    $SENDSQL <<EOF
SELECT table_name, table_rows
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = '$DB'
;
EOF
}

tstamp=`date +"%Y-%m-%d"`

# call the main function and record both std out and std err
main 2> $LOGPATH/error_log_$tstamp > $LOGPATH/output_log_$tstamp


# check of errors
errlines=`wc -l $LOGPATH/error_log_$tstamp | cut -d' ' -f1`
if [ $errlines -gt 0 ]
then
    if [ $errlines -le 3 ]
    then
	echo "THE FOLLOWING ERRORS HAVE BEEN DETECTED: "
	cat $LOGPATH/error_log_$tstamp
    else
	echo "SOME ERRORS OCCURRED."
	echo "IT MAY BE SAFE TO IGNORE THEM, BUT PLEASE CHECK FILE $LOGPATH/error_log_$tstamp"
    fi
echo
fi

# check for warnings
warnlines=`cat $LOGPATH/output_log_$tstamp | grep Warning | wc -l`
if [ $warnlines -gt 0 ]
then
    if [ $warnlines -lt 10 ]
    then
	echo "THE FOLLOWING MySQL WARNINGS HAVE BEEN GENERATED: "
	cat cat $LOGPATH/output_log_$tstamp | grep Warning
    else
	echo "SOME MySQL WARNINGS HAVE BEEN GENERATED."
	echo "IT MAY BE SAFE TO IGNORE THEM, BUT PLEASE CHECK FILE $LOGPATH/output_log_$tstamp"
    fi
fi

echo
echo "CREATED TABLES HAVE THE FOLLOWING NUMBERS OF ROWS"
echo "PLEASE CHECK THEM AGAINST PATSTAT DOCUMENTATION"
# output table counters to console
grep -E "^tls.*$" $LOGPATH/output_log_$tstamp
