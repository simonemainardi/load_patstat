-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls206_person_full`;
CREATE TABLE `tls206_person_full` (
  person_id int unsigned NOT NULL,
  doc_sn_id int unsigned NOT NULL,
  appln_id int unsigned NOT NULL,
  wk_country CHAR(7) default '',
  wk_number CHAR(10) default '',
  wk_kind CHAR(2) default '',
  source CHAR(4) default '',
  a_i_flag CHAR(1) default '',
  seq_nr smallint unsigned default NULL,
  ctry_code CHAR(2) default '',
  nationality CHAR(2) default '',
  residence CHAR(2) default '',
  last_name varchar(400) default '',
  first_name varchar(80) default '',
  middle_name varchar(50) default '',
  address varchar(400) default '',
  city varchar(100) default '',
  state varchar(20) default '',
  zip_code varchar(25) default ''
)
MAX_ROWS = 50000000
ENGINE = MyISAM
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

INSERT INTO `tls206_person_full`
SELECT
  P.person_id
, P.doc_sn_id
,		P.appln_id
,		P.wk_country
,		P.wk_number
,		P.wk_kind
,		P.source
,		P.a_i_flag
,		P.seq_nr
,		P.country
,		P.nationality
,		P.residence
,		TRIM(MID(P.name_address,1,P.last_name_len))                                                                                        AS last_name
,		TRIM(MID(P.name_address,P.last_name_len+1,P.first_name_len ))                                                                      AS first_name
,		TRIM(MID(P.name_address,P.last_name_len+P.first_name_len+1,P.middle_name_len))                                                     AS middle_name
,		TRIM(MID(P.name_address,P.last_name_len+P.first_name_len+P.middle_name_len+1, P.street_len ))                                      AS address
,		TRIM(MID(P.name_address,P.last_name_len+P.first_name_len+P.middle_name_len+P.street_len+1,P.city_len ))                            AS city
,		TRIM(MID(P.name_address,P.last_name_len+P.first_name_len+P.middle_name_len+P.street_len+P.city_len+1,P.state_len  ))               AS state
,		TRIM(MID(P.name_address,P.last_name_len+P.first_name_len+P.middle_name_len+P.street_len+P.city_len+P.state_len+1, P.zip_code_len)) AS zip_code
FROM
`tls206_person_temp` P;

ALTER TABLE `tls206_person_temp` ADD PRIMARY KEY (`person_id`);

ALTER TABLE `tls206_person_full` ADD PRIMARY KEY (`person_id`),
      ADD INDEX ctry_code (`ctry_code` ASC), 
      ADD INDEX doc_sn_id (`doc_sn_id` ASC), 
      ADD INDEX appln_id (`appln_id` ASC);

