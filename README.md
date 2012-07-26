Import script for PATSTAT
=========================



Prerequisites
-------------

All PATSTAT txt files should be decompressed in a load path as configured in setup.sh

Use
---

Go in bin and:

 1. Configure setup.sh

```
    export APPL=patstat
    export REL=04
    export YEAR=2012
    export MYSQL=mysql
    export MYSQLADM=mysqladmin
    export MYSQLDUMP=mysqldump
    export MYISAMCHK=myisamchk
    export MYISAMPACK=myisampack
    export USER=root
    export PASS=root
    export SOCKET=/opt/local/var/run/mysql5/mysqld.sock
    export LOADPATH=/Users/Shared/PATSTAT-DVD
    export ZIPARCHIVE=/Users/Shared/PATSTAT-DVD
    export RELEASE=Patstat_${YEAR}_${REL}
    export MYSQLVARPATH=/var/mysql
    export DUMPFILE=$HOME/dumps/${RELEASE}.sql
```
    
 2. Execute `go` script and WAIT

```
    cd bin
    ./go
```

 3. You will find the logs in the base dir like:

```
    loading_log_20120511_0951.txt
    loading_err_20120511_0951.txt
```

 4. Backup patstat db with backup_db.sh

```
    backup_db.sh
```

 5. Make ITAAPPDB with mk_italian_db/select_italian_applicants.sql

```
    cd ../make_italian_db
    mysql -uroot -p
    mysql> source select_italian_applicants.sql
```

 6. be happy

