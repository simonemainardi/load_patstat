-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls203_appln_abstr`;
CREATE TABLE IF NOT EXISTS `tls203_appln_abstr` (
  appln_id int NOT NULL default 0,
  appln_abstract TEXT,
  PRIMARY KEY  (appln_id)
)  
MAX_ROWS = 40000000
AVG_ROW_LENGTH=800
ENGINE = MyISAM
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

