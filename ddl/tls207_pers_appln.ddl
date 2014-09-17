-- -*- mode: sql -*-
DROP TABLE IF EXISTS `tls207_pers_appln`;
CREATE TABLE IF NOT EXISTS `tls207_pers_appln` (
  person_id int NOT NULL default '0',
  appln_id int NOT NULL default '0',
  applt_seq_nr smallint NOT NULL default '0',
  invt_seq_nr smallint NOT NULL default '0',
  PRIMARY KEY  (person_id, appln_id),
  INDEX `IX_person_id`(`person_id`),
  INDEX `IX_appln_id` (`appln_id`)
)
ENGINE = MyISAM
MAX_ROWS = 190000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
