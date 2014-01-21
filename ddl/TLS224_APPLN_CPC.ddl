-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS224_APPLN_CPC`;
CREATE TABLE `TLS222_APPLN_CPC` (
  appln_id  int(10) unsigned NOT NULL,
  	`cpc_class_symbol` VARCHAR(19) NOT NULL DEFAULT '',
	`cpc_scheme` VARCHAR(5) NOT NULL DEFAULT '',
	`cpc_version` DATE NOT NULL DEFAULT '9999-12-31',
	`cpc_value` CHAR(1) NOT NULL DEFAULT '',
	`cpc_position` CHAR(1) NOT NULL DEFAULT '',
	`cpc_gener_auth` char(2) NOT NULL DEFAULT ''
)
ENGINE = MyISAM
MAX_ROWS = 140000000
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

