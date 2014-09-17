-- -*- mode: sql -*-
DROP TABLE IF EXISTS  `tls211_pat_publn`;
CREATE TABLE IF NOT EXISTS  `tls211_pat_publn` (
`pat_publn_id` int NOT NULL default '0',
`publn_auth` char(2) NOT NULL default '',
`publn_nr` varchar(15) NOT NULL default '',
`publn_kind` char(2) NOT NULL default '',
`appln_id` int NOT NULL default '0',
`publn_date` date NOT NULL DEFAULT '9999-12-31',
`publn_lg` char(2) NOT NULL default '',
`publn_first_grant` tinyint NOT NULL default '0',
`publn_claims` smallint,
PRIMARY KEY  (`pat_publn_id`),
KEY `IX_publn_auth` (`publn_auth` ASC, `publn_nr` ASC, `publn_kind` ASC),
KEY `IX_appln_id` (`appln_id`),
KEY `IX_publn_date` (`publn_date`)
)
ENGINE = MyISAM
MAX_ROWS = 90000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
