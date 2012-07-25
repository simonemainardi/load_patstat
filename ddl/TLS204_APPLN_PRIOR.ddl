-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS204_APPLN_PRIOR`;
CREATE TABLE IF NOT EXISTS `TLS204_APPLN_PRIOR` (
  appln_id int(10) NOT NULL default '0',
  prior_appln_id int(10) NOT NULL default '0',
  prior_appln_seq_nr smallint(4) NOT NULL default '0',
  PRIMARY KEY  (appln_id,prior_appln_id),
  INDEX (prior_appln_id)
)  DEFAULT CHARSET=utf8 
MAX_ROWS = 50000000
AVG_ROW_LENGTH = 800
ENGINE = MyISAM
CHARACTER SET utf8 COLLATE utf8_unicode_ci;
