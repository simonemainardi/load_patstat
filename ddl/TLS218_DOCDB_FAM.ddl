-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls218_docdb_fam`;
CREATE TABLE IF NOT EXISTS `tls218_docdb_fam` (
  appln_id int NOT NULL default '0',
  docdb_family_id int NOT NULL default '0',
  PRIMARY KEY  (appln_id,docdb_family_id),
  INDEX (`docdb_family_id`)
)
ENGINE = MyISAM
MAX_ROWS = 80000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;

