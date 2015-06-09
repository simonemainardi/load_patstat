Import PATSTAT into MySQL
=========================

European Patent Office (EPO) database PATSTAT is a snapshot of the EPO master documentation database (DOCDB) with worldwide coverage, containing approximately 20 tables including bibliographic data, citations and family links.

PATSTAT is shipped as a bunch of zipped, csv files spread across multiple DVDs. Unfortunately, existing scripts and documentation only help users loading raw data into MSSQL databases.

This utility wants to make it easy for everyone to build a *PATSTAT MySQL* database from raw csv data. To achieve high-performances, database tables are compressed.

Currenly, there is full compatibility with both version Spring and Autumn 2014, also known as 2014a and 2014b.

Prerequisites
-------------
Every zipped file found in PATSTAT DVDs 1 to 3 should be copied into folder `data`. TLS221_INPADOC_PRS DVD zipped table may be copied there as well.

Usage
------

Run `load_patstat.sh` without parameters to display a brief help. Mandatory parameters are mysql_user and password, as well as hysql database host and name. Optionally, a `-v` may be passed to obtain a verbose output. For testing purposes one may want to pass the modifies `-t` that only loads small portions of zipped csv files.

```
$ ./load_patstat.sh
Usage: [-v] [-t] -u mysql_user -p mysql_pass -h mysql_host -d mysql_dbname
  -v: be verbose
  -t: load small chunks of data for testing purposes

```

Examples
--------
Load a **test** PASTSTAT database into a MySQL database on `localhost` named `patstat2014b` -- note the `-t` modifier.

```
$ ./load_patstat.sh -u<USER> -p<PASSWORD> -hlocalhost -d patstat2014b -t

```

Load a **full** PATSTAT database into a `localhost` MySQL database `patstat2014b`.

```
$ ./load_patstat.sh -u<USER> -p<PASSWORD> -hlocalhost -d patstat2014b

```

Troubleshooting
---------------
This utility must have write privileges into MySQL data folder. This is necessary to compress database tables and to work with table indices. Make sure the user that executes `load_patstat.sh` has such privileges.
