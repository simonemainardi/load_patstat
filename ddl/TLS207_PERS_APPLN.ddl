-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS207_PERS_APPLN`;
CREATE TABLE IF NOT EXISTS `TLS207_PERS_APPLN` (
  person_id int(10) NOT NULL default '0',
  appln_id int(10) NOT NULL default '0',
  applt_seq_nr smallint(4) NOT NULL default '0',
  invt_seq_nr smallint(4) NOT NULL default '0',
  PRIMARY KEY  (person_id,appln_id),
  INDEX (person_id),
  INDEX (appln_id)
)
ENGINE = MyISAM
MAX_ROWS = 127000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
