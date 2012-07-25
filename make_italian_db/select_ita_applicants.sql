
-- Search and replace patstat201204 with new db

-- Make IT applicant at EPO
--
DROP DATABASE IF EXISTS `itaappdb`;
CREATE DATABASE IF NOT EXISTS `itaappdb`;
USE `itaappdb`;


SET @ctry_code = "IT";
SET @appln_auth = "EP";

-- ---------------------------------------- STEP 2. Query di selezione delle PERSON_ID in EXTRACTING_PERSON_ID

drop table if exists `EXTRACTING_PERSON_ID`;
create table `EXTRACTING_PERSON_ID` as
select person_id from `patstat201204`.`TLS206_PERSON_FULL`
 where ctry_code=@ctry_code ;
ALTER TABLE `EXTRACTING_PERSON_ID` 
ADD PRIMARY KEY (`person_id`) ;
-- 201104 604804 rows affected (23.51 sec)
-- 201204 621883 rows affected (33.49 sec)


-- Persone Iniziali selezionate: 604.804

-- ---------------------------------------- STEP 3. Query di selezione delle APPLN_ID  in EXTRACING_APPLN_ID

drop table if exists `IN_EXTRACTING_APPLN_ID`;
create table `IN_EXTRACTING_APPLN_ID` as
select distinct t1.appln_id 
from `patstat201204`.`TLS207_PERS_APPLN`  t1
natural join `EXTRACTING_PERSON_ID` t2 ;
ALTER TABLE `IN_EXTRACTING_APPLN_ID` 
ADD PRIMARY KEY (`appln_id`) ;
-- 201104, 743844 rows affected (30.15 sec)
-- 201204, 760623 rows affected (1 min 28.53 sec)


drop table if exists `EXTRACTING_APPLN_ID`;
create table `EXTRACTING_APPLN_ID` as
select t1.appln_id 
from `IN_EXTRACTING_APPLN_ID` t1
natural join `patstat201204`.`TLS201_APPLN`  t0
where t0.appln_auth = @appln_auth;
ALTER TABLE `EXTRACTING_APPLN_ID` 
ADD PRIMARY KEY (`appln_id`) ;
-- 201204, 109435 rows affected (0.28 sec)

# source ~/Sites/Dropbox/Work/exedre.net/w/PATSTAT/import/LOADPATSTAT_201204/make_italian_db/mkdb.sql;

source mkdb.sql

-- 201204, 
