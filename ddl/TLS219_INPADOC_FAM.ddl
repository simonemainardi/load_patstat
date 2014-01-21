-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS219_INPADOC_FAM`;
CREATE TABLE IF NOT EXISTS `TLS219_INPADOC_FAM` (
  appln_id int(10) NOT NULL default '0',
  inpadoc_family_id int(10) NOT NULL default '0',
  PRIMARY KEY  (appln_id)
)
ENGINE = MyISAM
MAX_ROWS = 75000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
