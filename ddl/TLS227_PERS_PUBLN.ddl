-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS227_PERS_PUBLN`;
CREATE TABLE `TLS227_PERS_PUBLN` (
	`person_id` int NOT NULL DEFAULT 0,
	`pat_publn_id` int NOT NULL DEFAULT 0,
	`applt_seq_nr` smallint NOT NULL DEFAULT 0,
	`invt_seq_nr` smallint NOT NULL DEFAULT 0,
	PRIMARY KEY (`person_id`, `pat_publn_id`, `applt_seq_nr`, `invt_seq_nr`),
	INDEX (`pat_publn_id`),
	INDEX (`person_id`)
)
ENGINE = MyISAM
MAX_ROWS = 210000000
CHARACTER SET utf8 COLLATE utf8_unicode_ci;

