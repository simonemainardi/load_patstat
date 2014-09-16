-- -*- mode: sql -*-

DROP TABLE IF EXISTS `TLS206_PERSON_TEMP`;
--
--
CREATE TABLE `TLS206_PERSON_TEMP` (
  person_id int unsigned NOT NULL,
  doc_sn_id int unsigned NOT NULL,
  appln_id int unsigned NOT NULL,
  wk_country CHAR(7) default '',
  wk_number CHAR(10) default '',
  wk_kind CHAR(2) default '',
  source CHAR(4) default '',
  a_i_flag CHAR(1) default '',
  seq_nr int(4) unsigned default NULL,
  country CHAR(2) default '',
  nationality CHAR(2) default '',
  residence CHAR(2) default '',
  uspto_role CHAR(2) default '',
  last_name_len int(3) not NULL,
  first_name_len int(3) not NULL,
  middle_name_len int(3) not NULL,
  street_len int(3) not NULL,
  city_len int(3) not NULL,
  state_len int(3) not NULL,
  zip_code_len int(3) not NULL, 
  name_address VARCHAR(439) default ''
-- NAME_ADDRESS VARCHAR(442) default ''
)
MAX_ROWS = 50000000
ENGINE = MyISAM
CHARACTER SET latin1 COLLATE latin1_general_ci;
-- Achtung: input coding is latin1?!?


