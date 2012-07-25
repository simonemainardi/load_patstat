-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS222_APPLN_JP_CLASS`;
CREATE TABLE `TLS222_APPLN_JP_CLASS` (
  appln_id  int(10) unsigned NOT NULL,
  jp_class_scheme VARCHAR(6) NOT NULL,  
  jp_class_symbol VARCHAR(50) NOT NULL
)
ENGINE = MyISAM
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

