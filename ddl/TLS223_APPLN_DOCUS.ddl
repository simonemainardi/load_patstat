-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS223_APPLN_DOCUS`;
CREATE TABLE `TLS223_APPLN_DOCUS` (
  appln_id  int(10) unsigned NOT NULL,
  docus_class_symbol VARCHAR(50) NOT NULL
  PRIMARY KEY (appln_id,docus_class_symbol)
)
ENGINE = MyISAM
MAX_ROWS = 3700000
CHARACTER SET utf8 COLLATE utf8_unicode_ci;























