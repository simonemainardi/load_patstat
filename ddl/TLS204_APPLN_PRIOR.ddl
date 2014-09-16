-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS204_APPLN_PRIOR`;
CREATE TABLE IF NOT EXISTS `TLS204_APPLN_PRIOR` (
  appln_id int NOT NULL default 0,
  prior_appln_id int NOT NULL default 0,
  prior_appln_seq_nr smallint NOT NULL default 0,
  PRIMARY KEY  (appln_id,prior_appln_id),
  INDEX `IX_prior_appln_id` (`prior_appln_id`)
)  DEFAULT CHARSET=utf8 
MAX_ROWS = 40000000
AVG_ROW_LENGTH = 800
ENGINE = MyISAM
CHARACTER SET utf8 COLLATE utf8_unicode_ci;
