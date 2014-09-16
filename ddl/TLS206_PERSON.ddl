-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS206_PERSON`;
CREATE TABLE IF NOT EXISTS `TLS206_PERSON` (
  person_id int NOT NULL default '0',
  person_ctry_code char(2) NOT NULL default '',
  doc_std_name_id int NOT NULL default '0',
  person_name VARCHAR(300) NOT NULL,
  person_address VARCHAR(1000) NOT NULL,
  PRIMARY KEY  (person_id),
  INDEX `IX_person_ctry_code` (`person_ctry_code`)
)
ENGINE = MyISAM
MAX_ROWS = 4500000
AVG_ROW_LENGTH = 100
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
