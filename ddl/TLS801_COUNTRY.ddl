DROP TABLE IF EXISTS `TLS206_COUNTRY`;
CREATE TABLE IF NOT EXISTS `TLS206_COUNTRY` (
  ctry_code varchar(2) NOT NULL default '',
  st3_name varchar(100) not null default '',
  state_indicator char(1) not null default '',
  continent varchar(25) not null default '',
  eu_member char(1) not null default '',
  epo_member char(1) not null default '',
  oecd_member char(1) not null default '',
  discontinued char(1) not null default '',
  PRIMARY KEY  (ctry_code)
)
ENGINE = MyISAM
MAX_ROWS = 300
AVG_ROW_LENGTH = 100
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
