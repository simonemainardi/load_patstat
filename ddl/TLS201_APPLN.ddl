-- -*- mode: sql -*-
DROP TABLE IF EXISTS  `TLS201_APPLN` ;
CREATE TABLE IF NOT EXISTS  `TLS201_APPLN` (  
`appln_id` int(10) NOT NULL default '0',  
`appln_auth` char(2) NOT NULL default '',
`appln_nr` char(15) NOT NULL default '',
`appln_kind` char(2) NOT NULL default '00',
`appln_filing_date` date default NULL,
`appln_nr_epodoc` varchar(20) not null default '',
`ipr_type` char(2) NOT NULL default '',
`appln_title_lg` char(2) NOT NULL default '',
`appln_abstract_lg` char(2) NOT NULL default '',
`internat_appln_id` int(10) NOT NULL default '0',
PRIMARY KEY  (`appln_id`),
KEY `internat_appln_id` (`internat_appln_id`),
KEY `appln_auth` (`appln_auth`,`appln_nr`,`appln_kind`),
KEY `appln_filing_date` (`appln_filing_date`)
)
ENGINE = MyISAM
MAX_ROWS = 76000000
CHARACTER SET utf8 COLLATE utf8_unicode_ci;
