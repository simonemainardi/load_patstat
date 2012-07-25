-- Questo file a partire da patstat201204 (itafull) provvede a creare itaappdb

-- Parameters:
--   Input Database `patstat201104`
--   Output Database `patstat201204`
--   Where-clause selecting person: ctry_code = "IT"
-- DEFINE THIS---------------v

-- ---------------------------------------- STEP 1. Creazione nuovo database:

-- 

-- Application Iniziali a partire dalle persone: 743.844

-- ---------------------------------------- STEP 4. 4. Estrazione di tutte le application correlate con quelle base

-- Crea una tabella temporanea con tutte le APPLN_ID iniziali
-- 
drop table if exists `TEMP_EXTRACTING_APPLN_ID`;
create table `TEMP_EXTRACTING_APPLN_ID` as
select * from `EXTRACTING_APPLN_ID`;
ALTER TABLE `TEMP_EXTRACTING_APPLN_ID` 
ADD PRIMARY KEY (`appln_id`) ;
drop table if exists `ALL_EXTRACTING_APPLN_ID`;
create table `ALL_EXTRACTING_APPLN_ID` as
select * from `EXTRACTING_APPLN_ID`;
ALTER TABLE `ALL_EXTRACTING_APPLN_ID` 
ADD PRIMARY KEY (`appln_id`) ;

-- A questo punto in ALL_EXTRACTING_APPLN_ID e TEMP_EXTRACTING_APPLN_ID ci
-- sono veramente tutte le APPLN_ID da estrarre. cioè 743.844

-- 201204, 

-- ---------------------------------------- STEP 6. Selezione TLS201_APPLN in base a EXTRACTING_APPLN_ID

-- elenco dei person record selezionati
drop table if exists `TLS201_APPLN`;
create table `TLS201_APPLN` as
select t1.* from patstat201204.`TLS201_APPLN` t1
natural join `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS201_APPLN` 
ADD PRIMARY KEY (`appln_id`) ;

-- Query OK, 743.844 rows affected (43.34 sec)
-- 201204, 109435 rows affected (0.34 sec)
-- ---------------------------------------- STEP 7. Selezione TLS207_PERS_APPLN in base a EXTRACTING_APPLN_ID

drop table if exists `TEMP_EXTRACTING_PERSON_ID`;
create table `TEMP_EXTRACTING_PERSON_ID` as
select distinct person_id from  
`patstat201204`.`TLS207_PERS_APPLN`
natural join `ALL_EXTRACTING_APPLN_ID`;
ALTER TABLE `TEMP_EXTRACTING_PERSON_ID` 
ADD PRIMARY KEY (`person_id`) ;
-- Query OK, 813730 rows affected (25.85 sec)

drop table if exists `ALL_EXTRACTING_PERSON_ID`;
create table `ALL_EXTRACTING_PERSON_ID` as
select distinct * from `TEMP_EXTRACTING_PERSON_ID`;
ALTER TABLE `ALL_EXTRACTING_PERSON_ID` 
ADD PRIMARY KEY (`person_id`) ;
--  (48.68 sec)

-- A questo punto `ALL_EXTRACTING_APPLN_ID` e `TEMP_EXTRACTING_PERSON_ID` sono 813.730 person su 38.418.107

-- ---------------------------------------- STEP 8. Selezione TLS206_PERSON_FULL in base a EXTRACTING_PERSON_ID

drop table if exists `TLS206_PERSON_FULL`;
create table `TLS206_PERSON_FULL` as
select t1.* from patstat201204.`TLS206_PERSON_FULL` t1
natural join `ALL_EXTRACTING_PERSON_ID` t2 ;
ALTER TABLE `TLS206_PERSON_FULL` 
ADD PRIMARY KEY (`person_id`) ;
-- 813729 rows affected (12.67 sec)
ALTER TABLE `TLS206_PERSON_FULL` 
ADD INDEX `doc_sn_id` (`doc_sn_id` ASC) ;
ALTER TABLE `TLS206_PERSON_FULL` 
ADD INDEX `appln_id` (`appln_id` ASC) ;

drop table if exists `TLS207_PERS_APPLN`;
create table `TLS207_PERS_APPLN` as
select t1.* from patstat201204.`TLS207_PERS_APPLN` t1
natural join `ALL_EXTRACTING_PERSON_ID` t2 ;
ALTER TABLE `TLS207_PERS_APPLN` 
ADD PRIMARY KEY (`person_id`,`appln_id`) ;
ALTER TABLE `TLS207_PERS_APPLN` 
ADD INDEX `person_id` (`person_id` ASC) ;
ALTER TABLE `TLS207_PERS_APPLN` 
ADD INDEX `appln_id` (`appln_id` ASC) ;
-- 7937975 rows affected (36.89 sec)

-- ---------------------------------------- STEP 9. Selezione di TLS208_DOC_STD_NMS

drop table if exists `TLS208_DOC_STD_NMS`;
create table `TLS208_DOC_STD_NMS` as
select distinct t1.* from patstat201204.`TLS208_DOC_STD_NMS` t1
join  `TLS206_PERSON_FULL` t2 on doc_sn_id = doc_std_name_id;
ALTER TABLE `TLS208_DOC_STD_NMS` 
ADD PRIMARY KEY (`doc_std_name_id`) ;
-- 348119 rows affected (13.82 sec)

-- 10. Selezione di TLS202_TITLE 
--                 TLS203_ABSTRACT
--                 TLS204_APPLN_PRIOR
--                 TLS205_TECH_REL
--                 TLS209_APPLN_IPC
--                 TLS210_APPLN_N_CLS
--                 TLS211_PAT_PUBLN
--                 TLS216_APPL_CONTN
                

drop table if exists `TLS202_APPLN_TITLE`;
create table `TLS202_APPLN_TITLE` as
select distinct t1.* from patstat201204.`TLS202_APPLN_TITLE` t1
natural join  `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS202_APPLN_TITLE`
ADD PRIMARY KEY (`appln_id`) ;
-- 737851 rows affected (23.63 sec)

drop table if exists `TLS203_APPLN_ABSTR`;
create table `TLS203_APPLN_ABSTR` as
select distinct t1.* from patstat201204.`TLS203_APPLN_ABSTR` t1
natural join  `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS203_APPLN_ABSTR`
ADD INDEX (`appln_id`) ;
-- 276454 rows affected (6 min 59.94 sec)

drop table if exists `TLS204_APPLN_PRIOR`;
create table `TLS204_APPLN_PRIOR` as
select distinct t1.* from patstat201204.`TLS204_APPLN_PRIOR` t1
natural join  `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS204_APPLN_PRIOR`
ADD INDEX (`appln_id`) ;
-- 1176645 rows affected (52.54 sec)

drop table if exists `TLS205_TECH_REL`;
create table `TLS205_TECH_REL` as
select distinct  t1.* from patstat201204.`TLS205_TECH_REL` t1
natural join  `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS205_TECH_REL`
ADD INDEX (`appln_id`) ;
ALTER TABLE `TLS205_TECH_REL`
ADD PRIMARY KEY (`appln_id`,`tech_rel_appln_id`) ;
-- 42961 rows affected (4.38 sec)

drop table if exists `TLS209_APPLN_IPC`;
create table `TLS209_APPLN_IPC` as
select distinct t1.* from patstat201204.`TLS209_APPLN_IPC` t1
natural join  `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS209_APPLN_IPC`
ADD INDEX (`appln_id`) ;
-- 6203081 rows affected (2 min 53.75 sec)

drop table if exists `TLS210_APPLN_N_CLS`;
create table `TLS210_APPLN_N_CLS` as
select distinct t1.* from patstat201204.`TLS210_APPLN_N_CLS` t1
natural join  `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS210_APPLN_N_CLS`
ADD INDEX (`appln_id`) ;
-- 3475435 rows affected (47.03 sec)

drop table if exists `TLS211_PAT_PUBLN`;
create table `TLS211_PAT_PUBLN` as
select distinct t1.* from patstat201204.`TLS211_PAT_PUBLN` t1
natural join  `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS211_PAT_PUBLN`
ADD PRIMARY KEY (`pat_publn_id`) ;
ALTER TABLE `TLS211_PAT_PUBLN` 
ADD INDEX `appln_id` (`appln_id` ASC) ;
-- 1075624 rows affected (1 min 23.31 sec)

drop table if exists `TLS216_APPLN_CONTN`;
create table `TLS216_APPLN_CONTN` as
select distinct t1.* from patstat201204.`TLS216_APPLN_CONTN` t1
natural join  `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS216_APPLN_CONTN`
ADD INDEX (`appln_id`) ;
ALTER TABLE `TLS216_APPLN_CONTN`
ADD PRIMARY KEY (`appln_id`,`parent_appln_id`) ;
-- 12123 rows affected (2.40 sec)

drop table if exists `TLS223_APPLN_DOCUS`;
create table `TLS223_APPLN_DOCUS` as
select distinct t1.* from patstat201204.`TLS223_APPLN_DOCUS` t1
natural join  `ALL_EXTRACTING_APPLN_ID` t2 ;
ALTER TABLE `TLS223_APPLN_DOCUS`
ADD INDEX (`appln_id`) ;
-- ALTER TABLE `TLS223_APPLN_DOCUS` ADD PRIMARY KEY (`appln_id`,`parent_appln_id`) ;
-- 

-- ---------------------------------------- STEP 11. Selezione di TLS212_CITATION, 
--                                                                TLS214_NPL_PUBLN 
--                                                                TLS215_CITN_CATEG
drop table if exists `TLS212_CITATION`;
create table `TLS212_CITATION` as
select distinct t1.* from patstat201204.`TLS212_CITATION` t1
natural join  `TLS211_PAT_PUBLN`;
ALTER TABLE `TLS212_CITATION`
ADD PRIMARY KEY (`pat_publn_id`,`citn_id`) ;
ALTER TABLE `TLS212_CITATION`
ADD INDEX (`pat_publn_id`) ;
ALTER TABLE `TLS212_CITATION`
ADD INDEX (`cited_pat_publn_id`) ;
ALTER TABLE `TLS212_CITATION`
ADD INDEX (`npl_publn_id`) ;
-- 17396485 rows affected (2 min 16.62 sec)
--
drop table if exists `TLS214_NPL_PUBLN`;
create table `TLS214_NPL_PUBLN` as
select distinct t1.* from patstat201204.`TLS214_NPL_PUBLN` t1
natural join  `TLS212_CITATION`;
ALTER TABLE `TLS214_NPL_PUBLN`
ADD PRIMARY KEY (`npl_publn_id`) ;
-- 189877 rows affected (2 min 26.26 sec)
--
drop table if exists `TLS215_CITN_CATEG`;
create table `TLS215_CITN_CATEG` as
select distinct t1.* from patstat201204.`TLS215_CITN_CATEG` t1
natural join  `TLS212_CITATION`;
ALTER TABLE `TLS215_CITN_CATEG`
ADD INDEX (`pat_publn_id`,`citn_id`) ;
-- 861554 rows affected (47.59 sec)
--
rename table `ALL_EXTRACTING_APPLN_ID` to `APPLN_ID`,   
             `EXTRACTING_APPLN_ID` to `BASE_APPLN_ID`,
             `ALL_EXTRACTING_PERSON_ID` to `PERSON_ID`, 
             `EXTRACTING_PERSON_ID` to `BASE_PERSON_ID`;
--
drop table `TEMP_EXTRACTING_APPLN_ID`,
           `TEMP_EXTRACTING_PERSON_ID`;         

---- FINE 
