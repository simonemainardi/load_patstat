-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS210_APPLN_N_CLS`;
CREATE TABLE IF NOT EXISTS `TLS210_APPLN_N_CLS` (
  appln_id int(10) NOT NULL default '0',
  nat_class_symbol char(15) NOT NULL default '',
  PRIMARY KEY  (appln_id,nat_class_symbol)
)
ENGINE = MyISAM
MAX_ROWS = 24000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
