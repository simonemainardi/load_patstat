-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS223_APPLN_DOCUS`;
CREATE TABLE `TLS223_APPLN_DOCUS` (
  appln_id  int NOT NULL default '0',
  docus_class_symbol VARCHAR(50) NOT NULL default '',
  PRIMARY KEY (appln_id,docus_class_symbol),
  INDEX (`docus_class_symbol`)
)
ENGINE = MyISAM
MAX_ROWS = 40000000
CHARACTER SET utf8 COLLATE utf8_unicode_ci;























