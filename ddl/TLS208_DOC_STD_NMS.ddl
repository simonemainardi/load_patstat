-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS208_DOC_STD_NMS`;
CREATE TABLE IF NOT EXISTS `TLS208_DOC_STD_NMS` (
  doc_std_name_id int NOT NULL default '0',
  doc_std_name VARCHAR(100) NOT NULL default '',
  PRIMARY KEY  (doc_std_name_id),
  INDEX `IX_doc_std_name` (`doc_std_name`)
)
ENGINE = MyISAM
MAX_ROWS = 20000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
