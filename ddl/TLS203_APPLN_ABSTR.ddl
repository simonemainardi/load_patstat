-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS203_APPLN_ABSTR`;
CREATE TABLE IF NOT EXISTS `TLS203_APPLN_ABSTR` (
  appln_id int(10) NOT NULL default '0',
  appln_abstract VARCHAR(4000) NOT NULL,
-- appln_abstract text          NOT NULL,  --< was
  PRIMARY KEY  (appln_id)
)  
MAX_ROWS = 31000000
AVG_ROW_LENGTH=800
ENGINE = MyISAM
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

