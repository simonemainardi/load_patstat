-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls204_appln_prior`;
CREATE TABLE IF NOT EXISTS `tls204_appln_prior` (
  appln_id int NOT NULL default 0,
  prior_appln_id int NOT NULL default 0,
  prior_appln_seq_nr smallint NOT NULL default 0,
  PRIMARY KEY  (appln_id,prior_appln_id),
  INDEX `IX_prior_appln_id` (`prior_appln_id`)
)  DEFAULT CHARSET=utf8 
MAX_ROWS = 34000000
AVG_ROW_LENGTH = 800
ENGINE = MyISAM
CHARACTER SET utf8 COLLATE utf8_unicode_ci;
