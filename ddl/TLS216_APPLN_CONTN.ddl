-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS216_APPLN_CONTN`;
CREATE TABLE IF NOT EXISTS `TLS216_APPLN_CONTN` (
  appln_id int(10) NOT NULL default '0',
  parent_appln_id int(10) NOT NULL default '0',
  contn_type char(3) NOT NULL default '',
  PRIMARY KEY  (appln_id,parent_appln_id)
)
ENGINE = MyISAM
MAX_ROWS = 2300000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
