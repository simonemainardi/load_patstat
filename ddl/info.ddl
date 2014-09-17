-- -*- mode: sql -*-
DROP TABLE IF EXISTS  `info` ;
CREATE TABLE IF NOT EXISTS  `info` (
`name`  char(128) NOT NULL,  
`kind` int NOT NULL ,
`text` char(255) ,
`value` FLOAT
) 
DEFAULT CHARSET=utf8;
