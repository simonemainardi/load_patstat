Import PATSTAT into MySQL
=========================

European Patent Office (EPO) database PATSTAT is a snapshot of the EPO master documentation database (DOCDB) with worldwide coverage, containing approximately 20 tables including bibliographic data, citations and family links.

PATSTAT is shipped as a bunch of zipped, csv files spread across multiple DVDs. Unfortunately, existing scripts and documentation only help users loading raw data into MSSQL databases.

This utility wants to make it easy for everyone to build a *PATSTAT MySQL* database from raw csv data. To achieve high-performances, database tables are compressed.

Currently, there is full compatibility with both version Spring and Autumn 2014, also known as 2014a and 2014b.

The utility is also capable of loading the standardized EEE-PPAT person table with harmonized assignee names and assignee sector allocations (https://www.ecoom.be/en/EEE-PPAT).

Prerequisites
-------------
Every zipped file found in PATSTAT DVDs 1 to 3 should be copied into folder `data`. TLS221_INPADOC_PRS DVD zipped table may be copied there as well.

#### Stantardized EEE-PPAT person table
EEE-PPAT stantardized person table can be downloaded using the link shipped with official PATSTAT documentation. Typically this table is bundled in a zip file (e.g., `EEE_PPAT_2014a.zip`) together with a leaflet and release notes.
To import the standardized table, the csv dump found in the zip package (e.g., `EEE_PPAT_April2014.csv`) should be copied into folder `data` and *renamed* to `tls909_part01.zip`. Imported data will be stored into `tls909_eee_ppat` database table.

Usage
------

Run `load_patstat.sh` without parameters to display a brief help. Mandatory parameters are mysql_user and password, as well as MySQL database host and name. Optionally, a `-v` may be passed to obtain a verbose output. For testing purposes one may want to pass the modifier `-t` to only loads small portions of zipped csv files. Output and error logs are written to `output_log_YYYY-MM-DD.HH:MM` and `error_log_YYYY-MM-DD.HH:MM` in the current workind directory. One may specify a different directory using the modifier `-o`.

```
$ ./load_patstat.sh
Usage: [-v] [-t] -u mysql_user -p mysql_pass -h mysql_host -d mysql_dbname
  -v: be verbose
  -t: load small chunks of data for testing purposes
  -n: load normalized EEE PPAT person table
  -o: output and error logs directory (defaults to ./)

```

Examples
--------
Load a **test** PASTSTAT database and the standardized person table into a MySQL database on `localhost` named `patstat2014b` -- note the `-t` modifier.

```
$ ./load_patstat.sh -u<USER> -p<PASSWORD> -hlocalhost -d patstat2014b -t -n

```

Load a **full** PATSTAT database and the standardized person table into a `localhost` MySQL database `patstat2014b`.

```
$ ./load_patstat.sh -u<USER> -p<PASSWORD> -hlocalhost -d patstat2014b -n

```

Troubleshooting
---------------
This utility must have write privileges into MySQL data folder. This is necessary to compress database tables and to work with table indices. Make sure the user that executes `load_patstat.sh` has such privileges.
