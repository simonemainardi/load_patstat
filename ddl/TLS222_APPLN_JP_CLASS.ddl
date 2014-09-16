-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS222_APPLN_JP_CLASS`;
CREATE TABLE `TLS222_APPLN_JP_CLASS` (
  appln_id int NOT NULL default '0',
  jp_class_scheme VARCHAR(5) NOT NULL default '',
  jp_class_symbol VARCHAR(50) NOT NULL default '',
PRIMARY KEY (appln_id,jp_class_scheme,jp_class_symbol),
INDEX (`jp_class_symbol`, `jp_class_scheme`)
)
ENGINE = MyISAM
MAX_ROWS=295000000 
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

