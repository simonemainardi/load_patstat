-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS222_APPLN_JP_CLASS`;
CREATE TABLE `TLS222_APPLN_JP_CLASS` (
  appln_id  int(10) unsigned NOT NULL,
  jp_class_scheme VARCHAR(5) NOT NULL,  
  jp_class_symbol VARCHAR(50) NOT NULL,
PRIMARY KEY (appn_in,jp_class_scheme,jp_class_symbol)
)
ENGINE = MyISAM
MAX_ROWS=295000000 
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

