export APPL=patstat
export REL=04
export YEAR=2012
export MYSQL="mysql5 --local-infile "
export MYSQLADM=mysqladmin5
export MYSQLDUMP=mysqldump5
export MYISAMCHK=myisamchk5
export MYISAMPACK=myisampack5
export USER=root
export PASS=root
export LOADPATH=/Users/Shared/PATSTAT-DVD
export ZIPARCHIVE=/Users/Shared/PATSTAT-DVD
export RELEASE=Patstat_${YEAR}_${REL}
export MYSQLVARPATH=/var/mysql
export DUMPFILE=$HOME/dumps/${RELEASE}.sql

#### DO NOT CHANGE BELOW THIS LINE
#
export DB=${APPL}${YEAR}${REL}
DEMO=${1-YES}
if [ $DEMO == "YES" ] ; then	
	export DB=${DB}_DEMO
fi
export SENDSQL="$MYSQL -u$USER -p$PASS $DB"
export DDL=$BASE/../ddl
#
####

