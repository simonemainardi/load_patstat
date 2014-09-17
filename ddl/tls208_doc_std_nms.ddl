-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls208_doc_std_nms`;
CREATE TABLE IF NOT EXISTS `tls208_doc_std_nms` (
  doc_std_name_id int NOT NULL default '0',
  doc_std_name VARCHAR(100) NOT NULL default '',
  PRIMARY KEY  (doc_std_name_id),
  INDEX `IX_doc_std_name` (`doc_std_name`)
)
ENGINE = MyISAM
MAX_ROWS = 25000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
