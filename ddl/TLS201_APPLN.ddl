-- -*- mode: sql -*-
DROP TABLE IF EXISTS  `tls201_appln` ;
CREATE TABLE IF NOT EXISTS  `tls201_appln` (
`appln_id` int NOT NULL default '0',
`appln_auth` char(2) NOT NULL default '',
`appln_nr` varchar(15) NOT NULL default '',
`appln_kind` char(2) NOT NULL default '00',
`appln_filing_date` date NOT NULL DEFAULT '9999-12-31',
`appln_nr_epodoc` varchar(20) not null default '',
`ipr_type` char(2) NOT NULL default '',
`appln_title_lg` char(2) NOT NULL default '',
`appln_abstract_lg` char(2) NOT NULL default '',
`internat_appln_id` int NOT NULL default '0',
PRIMARY KEY  (`appln_id`),
INDEX `IX_internat_appln_id` (`internat_appln_id`),
INDEX `IX_appln_auth` (`appln_auth`,`appln_nr`,`appln_kind`),
INDEX `IX_appln_filing_date` (`appln_filing_date`)
)
ENGINE = MyISAM
MAX_ROWS = 76000000
CHARACTER SET utf8 COLLATE utf8_unicode_ci;
