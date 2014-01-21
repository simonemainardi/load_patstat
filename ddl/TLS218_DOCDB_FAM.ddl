-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS218_DOCDB_FAM`;
CREATE TABLE IF NOT EXISTS `TLS218_DOCDB_FAM` (
  appln_id int(10) NOT NULL default '0',
  docdb_family_id int(10) NOT NULL default '0',
  PRIMARY KEY  (appln_id,docdb_family_id)
)
ENGINE = MyISAM
MAX_ROWS = 70000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;

