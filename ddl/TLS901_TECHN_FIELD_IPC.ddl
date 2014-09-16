DROP TABLE IF EXISTS `tls901_techn_field_ipc`;
CREATE TABLE IF NOT EXISTS `tls901_techn_field_ipc` (
  techn_field_nr tinyint NOT NULL default '0',
  techn_sector varchar(50) not null default '',
  techn_field varchar(50) not null default '',
  ipc_maingroup_symbol varchar(8) not null default '',
  PRIMARY KEY  (techn_field_nr, techn_sector, techn_field, ipc_maingroup_symbol)
)
ENGINE = MyISAM
MAX_ROWS = 1000
AVG_ROW_LENGTH = 100
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
