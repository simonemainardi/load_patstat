-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS215_CITN_CATEG`;
CREATE TABLE IF NOT EXISTS `TLS215_CITN_CATEG` (
  pat_publn_id int(10) NOT NULL default '0',
  citn_id smallint(4) NOT NULL default '0',
  citn_categ char(1) NOT NULL default '',
  PRIMARY KEY  (pat_publn_id,citn_id,citn_categ)
)
ENGINE = MyISAM
MAX_ROWS = 23000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
