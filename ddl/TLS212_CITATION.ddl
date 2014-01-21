-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS212_CITATION`;
CREATE TABLE IF NOT EXISTS `TLS212_CITATION` (
  pat_publn_id int(10) NOT NULL default '0',
  citn_id smallint(4) NOT NULL default '0',
  citn_origin char(5) NOT NULL default '',
  cited_pat_publn_id int(10) NOT NULL default '0',
  cited_appln_id int(10) unsigned NOT NULL,  
  pat_citn_seq_nr smallint(4) NOT NULL default '0',
  npl_publn_id int(10) NOT NULL default '0',
  npl_citn_seq_nr smallint(4) NOT NULL default '0',
  citn_gener_auth  CHAR(2) NOT NULL,
  PRIMARY KEY  (pat_publn_id, citn_id),
  INDEX (cited_pat_publn_id)
)
ENGINE = MyISAM
MAX_ROWS = 140000000
DEFAULT CHARSET utf8 PACK_KEYS=0 COLLATE utf8_unicode_ci;
