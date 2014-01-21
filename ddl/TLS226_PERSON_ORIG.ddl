-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS226_PERSON_ORIG`;
CREATE TABLE `TLS226_PERSON_ORIG` (
	`person_orig_id` int NOT NULL DEFAULT 0,
	`person_id` int NOT NULL DEFAULT 0,
	`source` char(5) NOT NULL DEFAULT '',
	`source_version` varchar(10) NOT NULL DEFAULT '',
	`name_freeform` varchar(500) NOT NULL DEFAULT '',
	`last_name` varchar(400) NOT NULL DEFAULT '',
	`first_name` varchar(200) NOT NULL DEFAULT '',
	`middle_name` varchar(50) NOT NULL DEFAULT '',
	`address_freeform` varchar(1000) NOT NULL DEFAULT '',
	`street` varchar(500) NOT NULL DEFAULT '',
	`city` varchar(200) NOT NULL DEFAULT '',
  	`zip_code` varchar(30) NOT NULL DEFAULT '',
	`state` char(2) NOT NULL DEFAULT '',
	`person_ctry_code` char(2) NOT NULL DEFAULT '',
	`residence_ctry_code` char(2) NOT NULL DEFAULT '',
	`role` varchar(2) NOT NULL DEFAULT '',
    PRIMARY KEY _p(person_orig_id)
)
ENGINE = MyISAM
MAX_ROWS = 48000000
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

