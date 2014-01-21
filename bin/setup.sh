export APPL=patstat
export REL=09
export YEAR=2013
export MYSQL="mysql --local-infile "
export MYSQLADM=mysqladmin
export MYSQLDUMP=mysqldump
export MYISAMCHK=myisamchk
export MYISAMPACK=myisampack
export USER=root
export PASS=root
export LOADPATH=/Volumes/octopus/PATSTAT-DVD
export ZIPARCHIVE=/Volumes/octopus/PATSTAT-DVD
export RELEASE=PATSTAT_${YEAR}_${REL}
export MYSQLVARPATH=/var/mysql
export DUMPFILE=$HOME/dumps/${RELEASE}.sql
export $REPO=gitpatstat

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

