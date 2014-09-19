-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls206_person`;
CREATE TABLE IF NOT EXISTS `tls206_person` (
  person_id int NOT NULL default '0',
  person_ctry_code char(2) NOT NULL default '',
  doc_std_name_id int NOT NULL default '0',
  person_name VARCHAR(300) NOT NULL,
  person_address VARCHAR(1000) NOT NULL,
  PRIMARY KEY  (person_id),
  INDEX `IX_person_ctry_code` (`person_ctry_code`),
  INDEX `IX_doc_std_name_id` (`doc_std_name_id`),
  INDEX `IX_person_name` (`person_name`)		
)
ENGINE = MyISAM
MAX_ROWS = 50000000
AVG_ROW_LENGTH = 100
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
