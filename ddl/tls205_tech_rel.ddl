-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls205_tech_rel`;
CREATE TABLE IF NOT EXISTS `tls205_tech_rel` (
  appln_id int NOT NULL default 0,
  tech_rel_appln_id int NOT NULL default 0,
  PRIMARY KEY  (appln_id,tech_rel_appln_id)
)
ENGINE = MyISAM
MAX_ROWS = 2500000
AVG_ROW_LENGTH = 100
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;