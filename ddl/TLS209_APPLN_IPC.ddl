-- -*- mode: sql -*-
DROP TABLE IF EXISTS  `TLS209_APPLN_IPC`;
CREATE TABLE IF NOT EXISTS  `TLS209_APPLN_IPC` (
`appln_id` int(10) NOT NULL default '0',
`ipc_class_symbol` char(15) NOT NULL default '',
`ipc_class_level` char(1) NOT NULL default '',
`ipc_version` date default NULL,
`ipc_value` char(1) NOT NULL default '',
`ipc_position` char(1) NOT NULL default '',
`ipc_gener_auth` char(2) NOT NULL default '',
PRIMARY KEY  (`appln_id`,`ipc_class_symbol`,`ipc_class_level`),
KEY `ipc_class_symbol` (`ipc_class_symbol`)
)
ENGINE = MyISAM
MAX_ROWS = 178000000
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;
