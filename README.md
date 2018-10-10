Import PATSTAT into MySQL
=========================

European Patent Office (EPO) database PATSTAT Global is a snapshot of the EPO master documentation database (DOCDB) with worldwide coverage, containing approximately 20 tables including bibliographic data, citations and family links.

PATSTAT is shipped as a bunch of zipped, csv files. Unfortunately, existing scripts and documentation only help users loading raw data into MSSQL databases.

This utility wants to make it easy for everyone to build a *PATSTAT MySQL* database from raw csv data. To achieve high-performances, database tables are compressed.

Currently, there is full compatibility with version Autumn 2018, also known as 2018b.


Prerequisites
-------------
Every zipped table file `tlsXXX_partYY.zip` found in PATSTAT usb sticks or downloadead archives should be copied into a single folder.


Usage
------

Run `load_patstat.sh` without parameters to display a brief help. Mandatory parameters are mysql_user and password, as well as MySQL database host and name. Optionally, a `-v` may be passed to obtain a verbose output. For testing purposes one may want to pass the modifier `-t` to only loads small portions of zipped csv files. Output and error logs are written to `output_log_YYYY-MM-DD` and `error_log_YYYY-MM-DD` in the current workind directory. One may specify a different directory using the modifier `-o`.

```
$ ./load_patstat.sh
Usage: [-v] [-t] -u mysql_user -p mysql_pass -h mysql_host -d mysql_dbname -z patstat_zips_dir
  -v: be verbose
  -t: load small chunks of data for testing purposes
  -z: directory containing patstat zipped files shipped in DVDs (defaults to ./data)
  -o: output and error logs directory (defaults to ./)
  -m: mysql data path (useful in combination with MyISAM engine)
  -e: mysql engine (defaults to MyISAM)

```

Since the 2018a release the preferred engine can now be used. The default engine is MyISAM. **Be sure to know the implications in preferring a specific engine**: import time, disk/cpu/memory usage can vary a lot, depending on your setup.

Examples
--------
Load a **test** PASTSTAT database and the standardized person table into a MySQL database on `localhost` named `patstat2017a` -- note the `-t` modifier. Zipped table files have been placed into the default folder `./data`.

```
$ ./load_patstat.sh -u<USER> -p<PASSWORD> -hlocalhost -d patstat2017a -t -n

```

Load a **full** PATSTAT database and the standardized person table into a `localhost` MySQL database `patstat2017a`. Again, zipped table files have been placed into the default folder `./data`.

```
$ ./load_patstat.sh -u<USER> -p<PASSWORD> -hlocalhost -d patstat2017a -n

```

Troubleshooting
---------------
Using MyISAM engine, the utility must have write privileges into MySQL data folder. This is necessary to compress database tables and to work with table indices. Make sure the user that executes `load_patstat.sh` has such privileges.
