-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls224_appln_cpc`;
CREATE TABLE `tls224_appln_cpc` (
  appln_id  int NOT NULL default '0',
  	`cpc_class_symbol` VARCHAR(19) NOT NULL DEFAULT '',
	`cpc_scheme` VARCHAR(5) NOT NULL DEFAULT '',
	`cpc_version` DATE NOT NULL DEFAULT '9999-12-31',
	`cpc_value` CHAR(1) NOT NULL DEFAULT '',
	`cpc_position` CHAR(1) NOT NULL DEFAULT '',
	`cpc_gener_auth` char(2) NOT NULL DEFAULT ''
)
ENGINE = MyISAM
MAX_ROWS = 150000000
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

