-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS202_APPLN_TITLE`;
CREATE TABLE IF NOT EXISTS `TLS202_APPLN_TITLE` (
  appln_id int NOT NULL default 0,
--  appln_title VARCHAR(3000) NOT NULL,
 appln_title text          NOT NULL, -- < was
  PRIMARY KEY  (appln_id)
)
MAX_ROWS       = 58000000
AVG_ROW_LENGTH = 600
ENGINE         = MyISAM
CHARACTER SET utf8 COLLATE utf8_unicode_ci;


