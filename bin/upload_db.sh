#! /bin/bash

# Usage:
#
# . ./upload_db.sh patstat NO | tee > upload.log
#
# Requisiti: gzcat, iconv, mysql, mysqladmin
#

set -x

LSOF=$(lsof -p $$ | grep -E "/"$(basename $0)"$")
MY_PATH=$(echo $LSOF | sed -r s/'^([^\/]+)\/'/'\/'/1 2>/dev/null)
if [ $? -ne 0 ]; then
## OSX
MY_PATH=$(echo $LSOF | sed -E s/'^([^\/]+)\/'/'\/'/1 2>/dev/null)
fi
BASE=$(dirname $MY_PATH)
. $BASE/setup.sh

export SENDSQL="$MYSQL -u$USER -p$PASS $DB"

mkgitrepo() {
    # test -f $LOADPATH/$RELEASE/$REPO/$2.txt && rm $LOADPATH/$RELEASE/$REPO/$2.txt
    test -d $LOADPATH/$RELEASE/$REPO || mkdir -p $LOADPATH/$RELEASE/$REPO
	for ((I=1; I<=$3; I++)); do
		PART=$(echo $I|sed "s/^\([0-9]\)$/0\\1/")
        TXTFILE=$LOADPATH/$RELEASE/$1/$2_part${PART}.txt
        if (( $I==1 )); then
            cat $TXTFILE > $LOADPATH/$RELEASE/$REPO/$2.txt
        else
            tail -n +2 $TXTFILE >> $LOADPATH/$RELEASE/$REPO/$2.txt
        fi
    done
}

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

create_merge_table() {
	# Crea la tabella
	awk  'BEGIN {a=1;} {if (a==1) print $0; } /^\)/ {a=0;}' <  $DDL/$1.ddl > /tmp/merge.ddl 
	echo "ENGINE=MERGE UNION=($2) INSERT_METHOD=LAST CHARACTER SET utf8 COLLATE utf8_general_ci;" >> /tmp/merge.ddl
	cat /tmp/merge.ddl | $SENDSQL
}

load_table() {
	TIME=$(date '+%F %T %Z')
	INTIME=$(date +%s)

	sleep 1

	if [ ! -d $ZIPARCHIVE/$RELEASE/$1 ]; then
		echo ERRORE: Il Path $ZIPARCHIVE/$RELEASE/$1 non esiste 
		exit
	fi

	create_table $4

	# FLUSH TABLES
	echo FLUSH TABLES \; | $SENDSQL

	# This removes all use of indexes for the table.
	$MYISAMCHK  --keys-used=0 -rq $MYSQLVARPATH/$DB/$4.MYI

	if [ $5 == 'YES' ]; then 
		echo ALTER TABLE $4 DISABLE KEYS\; | $SENDSQL ;
	fi

	echo TRUNCATE TABLE $4 \; | $SENDSQL ;


	echo -n $TIME Loading data in $4 from $2 files 


	for ((I=1; I<=$3; I++)); do
		PART=$(echo $I|sed "s/^\([0-9]\)$/0\\1/")
        TXTFILE=$LOADPATH/$RELEASE/$1/$2_part${PART}.txt

        if [ ! -f $TXTFILE ]; then
            GZFILE=$TXTFILE.gz
            if [ -f $GZFILE ]; then
                gzcat $GZFILE > $TXTFILE
            else
                exit -1
            fi
        fi


	    if [ $6 == 'YES' ]; then
		    mv $TXTFILE $TXTFILE-X
		    iconv -f ISO8859-1 -t UTF-8 $TXTFILE-X > $TXTFILE
		    rm $TXTFILE-X
	    fi
	    if [ $7 == 'CSV' ]; then
            READFILE=$TXTFILE
            if [ $DEMO == 'YES' ]; then
                cat $TXTFILE | head -100  > $TXTFILE-X
                READFILE=$TXTFILE-X
            fi
		    echo set autocommit = 0 \; set unique_checks = 0 \; set foreign_key_checks = 0 \; LOAD DATA LOCAL INFILE \"$READFILE\" INTO TABLE $4 FIELDS TERMINATED BY \",\" OPTIONALLY ENCLOSED BY \'\"\' LINES TERMINATED BY \'\\r\\n\' IGNORE 1 LINES \;   commit \;  ;
		    echo set autocommit = 0 \; set unique_checks = 0 \; set foreign_key_checks = 0 \; LOAD DATA LOCAL INFILE \"$READFILE\" INTO TABLE $4 FIELDS TERMINATED BY \",\" OPTIONALLY ENCLOSED BY \'\"\' LINES TERMINATED BY \'\\r\\n\' IGNORE 1 LINES \;   commit \;  | $SENDSQL ;
	    fi
	    if [ $7 == 'NO' ]; then
		    echo  LOAD DATA LOCAL INFILE \"$TXTFILE.txt\" INTO TABLE $4 FIELDS TERMINATED BY \"\" ENCLOSED BY \'\' LINES TERMINATED BY \'\\r\\n\' IGNORE 0 LINES \; | $SENDSQL ;
	    fi
	    if [ $7 == 'TAB' ]; then
		    echo LOAD DATA LOCAL INFILE \"$TXTFILE.txt\" INTO TABLE $4 FIELDS TERMINATED BY \"\" ENCLOSED BY \'\' LINES TERMINATED BY \'\\r\\n\' IGNORE 0 LINES \;  | $SENDSQL ;
	    fi

	    echo SHOW WARNINGS \; | $SENDSQL

	    if [ $5 == 'YES' ]; then 
		    echo ALTER TABLE $4 ENABLE KEYS \; | $SENDSQL ;
	    fi

		if [ $DEMO == "YES" ]; then
            rm $TXTFILE-X
        fi

    done
	# If you intend only to read from the table in the future, use myisampack to compress it. 
	$MYISAMPACK $MYSQLVARPATH/$DB/$4.MYI

	# Re-create the indexes
	$MYISAMCHK  -rq $MYSQLVARPATH/$DB/$4.MYI

	# FLUSH TABLES
	echo FLUSH TABLES \; | $SENDSQL

	count_table $@

	OUTTIME=$(date +%s)
	echo " $OUTTIME - $INTIME = "  $(( $OUTTIME - $INTIME )) sec " = " $(( ( $OUTTIME - $INTIME ) / 60 )) min
}

merge_tables() {	
	STR=""
	for ((I=1; I<=$3; I++)); do
		STR="$STR ${4}_$I"
		V=$3
		if (( I < V ))
		then 
			STR="$STR,"
		fi
	done
	create_merge_table $4 "$STR"
}



load_ascii_table() {

	TIME=$(date '+%F %T %Z')
	INTIME=$(date +%s)

	sleep 1

	if [ ! -d $LOADPATH/$RELEASE ]; then
		mkdir -p $LOADPATH/$RELEASE
	fi

	if [ ! -d $ZIPARCHIVE/$RELEASE/$1 ]; then
		echo ERRORE: Il Path $ZIPARCHIVE/$RELEASE/$1 non esiste 
		exit
	fi

	create_table $4


	if [ $5 == 'YES' ]; then 
		echo ALTER TABLE $4 DISABLE KEYS\; | $SENDSQL ;
	fi

	echo TRUNCATE TABLE $4 \; | $SENDSQL ;

	echo -n $TIME Loading data in $4 from $2 files 

	for ((I=1; I<=$3; I++)); do
		PART=$(echo $I|sed "s/^\([0-9]\)$/0\\1/")
        TXTFILE=$LOADPATH/$RELEASE/$1/$2_part${PART}.txt

        READFILE=$TXTFILE
		if [ $DEMO == "YES" ]; then
			cat $TXTFILE | head -100 > $TXTFILE-X
            READFILE=$TXTFILE-X
		fi
		if [ $6 == 'YES' ]; then
				mv $TXTFILE $TXTFILE-X
				iconv -f ISO8859-1 -t UTF-8 $TXTFILE-X > $TXTFILE
		fi
		if [ $7 == 'CSV' ]; then
            echo set autocommit = 0 \; set unique_checks = 0 \; set foreign_key_checks = 0 \; LOAD DATA LOCAL INFILE \"$READFILE\" INTO TABLE $4 FIELDS TERMINATED BY \"\" ENCLOSED BY \'\' LINES TERMINATED BY \'\\r\\n\' IGNORE 0 LINES \; | $SENDSQL ;
		fi
		if [ $DEMO == "YES" ]; then
            rm $TXTFILE-X
        fi
		PARTTIME=$(date)
	done

	if [ $5 == 'YES' ]; then 
		echo ALTER TABLE $4 ENABLE KEYS\; | $SENDSQL ;
	fi
	OUTTIME=$(date +%s)
	echo " $OUTTIME - $INTIME = "  $(( $OUTTIME - $INTIME )) sec " = " $(( ( $OUTTIME - $INTIME ) / 60 )) min
}

wc_file() {
	WC=0
	for ((I=1; I<=$3; I++)); do
		PART=$(echo $I|sed "s/^\([0-9]\)$/0\\1/")
		if  [ -f $ZIPARCHIVE/$RELEASE/$1/$2_part${PART}.txt.gz ]; then		  
			if [ $DEMO == "YES" ]; then
				WC1=$(gzcat $ZIPARCHIVE/$RELEASE/$1/$2_part${PART}.txt.gz | $DEMOCMD  | wc -l)
			else
				WC1=$(gzcat $ZIPARCHIVE/$RELEASE/$1/$2_part${PART}.txt.gz | wc -l)
			fi
			WC=$(( $WC + $WC1 - 1))
		fi
	done
	echo $2 "LINES=" $WC
}

count_table() {
	WC=$(echo SELECT COUNT\(\*\) FROM $4 | $SENDSQL)
	echo $2 $WC
}

mk_op_2013_09() {
OP=$1
    #Sector#File  #Parts    #Table                       #Disable_keys  # convert latin1->utf8  #CSV
$OP Data tls201    4         TLS201_APPLN                 YES            NO                      CSV
$OP Data tls202    3         TLS202_APPLN_TITLE           NO             NO                      CSV
$OP Data tls203    23        TLS203_APPLN_ABSTR           NO             NO                      CSV
$OP Data tls204    1         TLS204_APPLN_PRIOR           YES            NO                      CSV
$OP Data tls205    1         TLS205_TECH_REL              NO             NO                      CSV
$OP Data tls206    2        TLS206_PERSON                YES            NO                      CSV
$OP Data tls207    2        TLS207_PERS_APPLN            YES            NO                      CSV
$OP Data tls208    1         TLS208_DOC_STD_NMS           YES            NO                      CSV
$OP Data tls209    6        TLS209_APPLN_IPC             YES            NO                      CSV
$OP Data tls210    1         TLS210_APPLN_N_CLS           NO             NO                      CSV
$OP Data tls211    3         TLS211_PAT_PUBLN             YES            NO                      CSV
$OP Data tls212    6        TLS212_CITATION              YES            NO                      CSV
$OP Data tls214    2         TLS214_NPL_PUBLN             NO             NO                      CSV
$OP Data tls215    1         TLS215_CITN_CATEG            NO             NO                      CSV
$OP Data tls216    1         TLS216_APPLN_CONTN           NO             NO                      CSV
# $OP Data tls217             TLS217_APPLN_I_CLS          NO             NO                      CSV
$OP Data tls218    1         TLS218_DOCDB_FAM             NO             NO                      CSV
$OP Data tls219    1         TLS219_INPADOC_FAM           NO             NO                      CSV
$OP Data tls222    6        TLS222_APPLN_JP_CLASS         NO             NO                      CSV
$OP Data tls223    1         TLS223_APPLN_DOCUS           NO             NO                      CSV
$OP Data tls224    5         TLS224_APPLN_CPC             NO             NO                      CSV
$OP Data tls226    3         TLS226_PERSON_ORIG           NO             NO                      CSV
$OP Data tls227    3         TLS227_PERS_PUBLN            NO             NO                      CSV
}


mk_tls206_ascii(){
    #Sector #File           #Parts    #Table                      #Disable_keys   # convert latin1->utf8 #CSV
load_ascii_table TXT     tls206_ascii    5         TLS206_PERSON_TEMP          NO              NO                     CSV
send_ddl TLS206_PERSON_FULL 


}

mk_op_selective() {
OP=$1
      #Sector   #File     #Parts    #Table                     #Disable_keys   # convert latin1->utf8 #CSV
if [ x$2 == "xtls201" ]; then 
	$OP PATSTAT tls201    4         TLS201_APPLN                 YES            NO                      CSV
fi
if [ x$2 == "xtls202" ]; then 
	$OP PATSTAT tls202    4         TLS202_APPLN_TITLE           NO             NO                      CSV
fi
if [ x$2 == "xtls203" ]; then 
	$OP PATSTAT tls203    19        TLS203_APPLN_ABSTR           NO             NO                      CSV
fi
if [ x$2 == "xtls204" ]; then 
	$OP PATSTAT tls204    1         TLS204_APPLN_PRIOR           YES            NO                      CSV
fi
if [ x$2 == "xtls205" ]; then 
	$OP PATSTAT tls205    1         TLS205_TECH_REL              NO             NO                      CSV
fi
if [ x$2 == "xtls206" ]; then 
	$OP PATSTAT tls206    5         TLS206_PERSON                YES            NO                      CSV
fi
if [ x$2 == "xtls207" ]; then 
	$OP PATSTAT tls207    5         TLS207_PERS_APPLN            YES            NO                      CSV
fi
if [ x$2 == "xtls208" ]; then 
	$OP PATSTAT tls208    1         TLS208_DOC_STD_NMS           YES            NO                      CSV
fi
if [ x$2 == "xtls209" ]; then 
	$OP PATSTAT tls209    11        TLS209_APPLN_IPC             YES            NO                      CSV
fi
if [ x$2 == "xtls210" ]; then 
	$OP PATSTAT tls210    1         TLS210_APPLN_N_CLS           NO             NO                      CSV
fi
if [ x$2 == "xtls211" ]; then 
	$OP PATSTAT tls211    3         TLS211_PAT_PUBLN             YES            NO                      CSV
fi
if [ x$2 == "xtls212" ]; then 
	$OP PATSTAT tls212    5         TLS212_CITATION              YES            NO                      CSV
fi
if [ x$2 == "xtls214" ]; then 
	$OP PATSTAT tls214    1         TLS214_NPL_PUBLN             NO             NO                      CSV
fi
if [ x$2 == "xtls215" ]; then 
	$OP PATSTAT tls215    1         TLS215_CITN_CATEG            NO             NO                      CSV
fi
if [ x$2 == "xtls216" ]; then 
	$OP PATSTAT tls216    1         TLS216_APPLN_CONTN           NO             NO                      CSV
fi
if [ x$2 == "xtls217" ]; then 
	$OP PATSTAT tls217    2         TLS217_APPLN_I_CLS           NO             NO                      CSV
fi
if [ x$2 == "xtls218" ]; then 
	$OP PATSTAT tls218    1         TLS218_DOCDB_FAM             NO             NO                      CSV
fi
if [ x$2 == "xtls219" ]; then 
	$OP PATSTAT tls219    1         TLS219_INPADOC_FAM           NO             NO                      CSV
fi
if [ x$2 == "xtls222" ]; then 
	$OP PATSTAT tls218    1         TLS222_DOCDB_FAM             NO             NO                      CSV
fi
if [ x$2 == "xtls223" ]; then 
	$OP PATSTAT tls219    1         TLS223_INPADOC_FAM           NO             NO                      CSV
fi

           #Sector #File           #Parts    #Table                      #Disable_keys   # convert latin1->utf8 #CSV
if [ x$2 == "xtls206" ]; then 
	$OP PATSTAT tls206_ascii    4         TLS206_PERSON_TEMP          NO              YES                    NO
fi
}
