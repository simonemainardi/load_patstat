-- -*- mode: sql -*-
DROP TABLE IF EXISTS `TLS214_NPL_PUBLN`;
CREATE TABLE IF NOT EXISTS `TLS214_NPL_PUBLN` (
  npl_publn_id int NOT NULL default '0',
  npl_biblio TEXT NOT NULL,
  PRIMARY KEY  (npl_publn_id)
)
ENGINE = MyISAM
MAX_ROWS = 25000000
AVG_ROW_LENGTH = 150
DEFAULT CHARSET utf8 COLLATE utf8_unicode_ci;


-- REPLACE INTO `INFO`
-- SET 
-- name = "tls214_npl_publn.npl_biblio.max_length",
-- kind = 1,
-- value = (SELECT MAX(LENGTH(npl_biblio)) FROM tls214_npl_publn);


-- REPLACE INTO `INFO`
-- SET 
-- name = "tls214_npl_publn.npl_biblio.avg_length",
-- kind = 1,
-- value = (SELECT AVG(LENGTH(npl_biblio)) FROM tls214_npl_publn);
