-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls210_appln_n_cls`;
CREATE TABLE IF NOT EXISTS `tls210_appln_n_cls` (
  appln_id int NOT NULL default '0',
  nat_class_symbol varchar(15) NOT NULL default '',
  PRIMARY KEY  (appln_id,nat_class_symbol)
)
ENGINE = MyISAM
MAX_ROWS = 22000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
