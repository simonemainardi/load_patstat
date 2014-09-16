DROP TABLE IF EXISTS `tls802_legal_event_code`;
CREATE TABLE IF NOT EXISTS `tls802_legal_event_code` (
  lec_id smallint NOT NULL default '0',
  auth_cc varchar(2) not null default '',
  lec_name varchar(4) not null default '',
  nat_auth_cc varchar(2) not null default '',
  nat_lec_name varchar(4) not null default '',
  impact char(1) not null default '',
  lec_descr varchar(250) not null default '',
  lecg_id tinyint not null default '0',
  lecg_name varchar(6) not null default '',
  lecg_descr varchar(150) not null default '',
  PRIMARY KEY  (lec_id)
)
ENGINE = MyISAM
MAX_ROWS = 3500
AVG_ROW_LENGTH = 100
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
