-- -*- mode: sql -*-
DROP TABLE IF EXISTS  `tls209_appln_ipc`;
CREATE TABLE IF NOT EXISTS  `tls209_appln_ipc` (
`appln_id` int NOT NULL default '0',
`ipc_class_symbol` varchar(15) NOT NULL default '',
`ipc_class_level` char(1) NOT NULL default '',
`ipc_version` date NOT NULL DEFAULT '9999-12-31',
`ipc_value` char(1) NOT NULL default '',
`ipc_position` char(1) NOT NULL default '',
`ipc_gener_auth` char(2) NOT NULL default '',
PRIMARY KEY  (`appln_id`,`ipc_class_symbol`,`ipc_class_level`),
INDEX `IX_ipc_class_symbol` (`ipc_class_symbol`)
)
ENGINE = MyISAM
MAX_ROWS = 200000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
