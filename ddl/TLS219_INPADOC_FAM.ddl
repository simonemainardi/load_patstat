-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS219_INPADOC_FAM`;
CREATE TABLE IF NOT EXISTS `TLS219_INPADOC_FAM` (
  appln_id int NOT NULL default '0',
  inpadoc_family_id int NOT NULL default '0',
  PRIMARY KEY  (appln_id),
  INDEX (`inpadoc_family_id`)
)
ENGINE = MyISAM
MAX_ROWS = 80000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
