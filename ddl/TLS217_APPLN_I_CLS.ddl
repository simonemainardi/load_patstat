-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS217_APPLN_I_CLS`;
CREATE TABLE IF NOT EXISTS `TLS217_APPLN_I_CLS` (
  appln_id int(10) NOT NULL default '0',
  ico_class_symbol char(15) NOT NULL default '',
  PRIMARY KEY  (appln_id,ico_class_symbol)
)
ENGINE = MyISAM
MAX_ROWS = 200000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
