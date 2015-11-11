if [[ $# != 1 ]]
then
    echo "Usage: $0 <database_name>"
    exit 1
fi

DBNAME=$1

cat <<EOF
CREATE DATABASE IF NOT EXISTS $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;

USE $DBNAME;

CREATE TABLE tls201_appln (
  appln_id int(11) NOT NULL DEFAULT '0',
  appln_auth char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  appln_nr varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  appln_kind char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '00',
  appln_filing_date date NOT NULL DEFAULT '9999-12-31',
  appln_nr_epodoc varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  ipr_type char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  appln_title_lg char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  appln_abstract_lg char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  internat_appln_id int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (appln_id),
  KEY IX_internat_appln_id (internat_appln_id),
  KEY IX_appln_auth (appln_auth,appln_nr,appln_kind),
  KEY IX_appln_filing_date (appln_filing_date),
  KEY IX_appln_kind (appln_kind)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls202_appln_title (
  appln_id int(11) NOT NULL DEFAULT '0',
  appln_title_lg char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  appln_title text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (appln_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=600;



CREATE TABLE tls203_appln_abstr (
  appln_id int(11) NOT NULL DEFAULT '0',
  appln_abstract_lg char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  appln_abstract text COLLATE utf8_unicode_ci,
  PRIMARY KEY (appln_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=800;



CREATE TABLE tls204_appln_prior (
  appln_id int(11) NOT NULL DEFAULT '0',
  prior_appln_id int(11) NOT NULL DEFAULT '0',
  prior_appln_seq_nr smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (appln_id,prior_appln_id),
  KEY IX_prior_appln_id (prior_appln_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=800;



CREATE TABLE tls205_tech_rel (
  appln_id int(11) NOT NULL DEFAULT '0',
  tech_rel_appln_id int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (appln_id,tech_rel_appln_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls206_person (
  person_id int(11) NOT NULL DEFAULT '0',
  person_name varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  person_address varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  person_ctry_code char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  doc_std_name_id int(11) NOT NULL DEFAULT '0',
  doc_std_name varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (person_id),
  KEY IX_person_ctry_code (person_ctry_code),
  KEY IX_doc_std_name_id (doc_std_name_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls207_pers_appln (
  person_id int(11) NOT NULL DEFAULT '0',
  appln_id int(11) NOT NULL DEFAULT '0',
  applt_seq_nr smallint(6) NOT NULL DEFAULT '0',
  invt_seq_nr smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (person_id,appln_id,applt_seq_nr,invt_seq_nr),
  KEY IX_person_id (person_id),
  KEY IX_appln_id (appln_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls209_appln_ipc (
  appln_id int(11) NOT NULL DEFAULT '0',
  ipc_class_symbol varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  ipc_class_level char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  ipc_version date NOT NULL DEFAULT '9999-12-31',
  ipc_value char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  ipc_position char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  ipc_gener_auth char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,ipc_class_symbol,ipc_class_level),
  KEY IX_ipc_class_symbol (ipc_class_symbol)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls210_appln_n_cls (
  appln_id int(11) NOT NULL DEFAULT '0',
  nat_class_symbol varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,nat_class_symbol)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls211_pat_publn (
  pat_publn_id int(11) NOT NULL DEFAULT '0',
  publn_auth char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  publn_nr varchar(15) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  publn_kind char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  appln_id int(11) NOT NULL DEFAULT '0',
  publn_date date NOT NULL DEFAULT '9999-12-31',
  publn_lg char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  publn_first_grant tinyint(4) NOT NULL DEFAULT '0',
  publn_claims smallint(6) DEFAULT NULL,
  PRIMARY KEY (pat_publn_id),
  KEY IX_publn_auth (publn_auth,publn_nr,publn_kind),
  KEY IX_appln_id (appln_id),
  KEY IX_publn_date (publn_date),
  KEY IX_publ_lg (publn_lg)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls212_citation (
  pat_publn_id int(11) NOT NULL DEFAULT '0',
  citn_id smallint(6) NOT NULL DEFAULT '0',
  citn_origin char(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  cited_pat_publn_id int(11) NOT NULL DEFAULT '0',
  cited_appln_id int(10) unsigned NOT NULL DEFAULT '0',
  pat_citn_seq_nr smallint(6) NOT NULL DEFAULT '0',
  npl_publn_id int(11) NOT NULL DEFAULT '0',
  npl_citn_seq_nr smallint(6) NOT NULL DEFAULT '0',
  citn_gener_auth char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (pat_publn_id,citn_id),
  KEY IX_cited_pat_publn_id (cited_pat_publn_id),
  KEY cited_appln_id (cited_appln_id,pat_publn_id),
  KEY IX_pat_citn_seq_nr (pat_citn_seq_nr),
  KEY IX_npl_citn_seq_nr (npl_citn_seq_nr),
  KEY IX_npl_publn_id (npl_publn_id),
  KEY IX_cited_pub_seq_nr (cited_pat_publn_id,pat_citn_seq_nr),
  KEY IX_cited_app_seq_nr (cited_appln_id,pat_citn_seq_nr)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  PACK_KEYS=0;



CREATE TABLE tls214_npl_publn (
  npl_publn_id int(11) NOT NULL DEFAULT '0',
  npl_biblio text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (npl_publn_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=150;



CREATE TABLE tls215_citn_categ (
  pat_publn_id int(11) NOT NULL DEFAULT '0',
  citn_id smallint(6) NOT NULL DEFAULT '0',
  citn_categ char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (pat_publn_id,citn_id,citn_categ)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls216_appln_contn (
  appln_id int(11) NOT NULL DEFAULT '0',
  parent_appln_id int(11) NOT NULL DEFAULT '0',
  contn_type char(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,parent_appln_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls218_docdb_fam (
  appln_id int(11) NOT NULL DEFAULT '0',
  docdb_family_id int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (appln_id,docdb_family_id),
  KEY docdb_family_id (docdb_family_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls219_inpadoc_fam (
  appln_id int(11) NOT NULL DEFAULT '0',
  inpadoc_family_id int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (appln_id),
  KEY inpadoc_family_id (inpadoc_family_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls221_inpadoc_prs (
  appln_id int(11) NOT NULL DEFAULT '0',
  prs_event_seq_nr smallint(6) NOT NULL DEFAULT '0',
  prs_gazette_date date NOT NULL DEFAULT '9999-12-31',
  prs_code char(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l501ep varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l502ep varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  lec_id smallint(6) NOT NULL DEFAULT '0',
  l503ep varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l504ep varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l505ep date NOT NULL DEFAULT '9999-12-31',
  l506ep varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l507ep varchar(300) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l508ep varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l509ep varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l510ep varchar(700) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l511ep varchar(20) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l512ep date NOT NULL DEFAULT '9999-12-31',
  l513ep date NOT NULL DEFAULT '9999-12-31',
  l515ep varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l516ep varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l517ep varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l518ep date NOT NULL DEFAULT '9999-12-31',
  l519ep varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l520ep tinyint(4) NOT NULL DEFAULT '0',
  l522ep varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  l523ep date NOT NULL DEFAULT '9999-12-31',
  l524ep varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  l525ep date NOT NULL DEFAULT '9999-12-31',
  PRIMARY KEY (appln_id,prs_event_seq_nr),
  KEY prs_gazette_date (prs_gazette_date,appln_id),
  KEY lec_id (lec_id,appln_id),
  KEY prs_code (prs_code,appln_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls222_appln_jp_class (
  appln_id int(11) NOT NULL DEFAULT '0',
  jp_class_scheme varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  jp_class_symbol varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,jp_class_scheme,jp_class_symbol),
  KEY jp_class_symbol (jp_class_symbol,jp_class_scheme)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls223_appln_docus (
  appln_id int(11) NOT NULL DEFAULT '0',
  docus_class_symbol varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,docus_class_symbol),
  KEY docus_class_symbol (docus_class_symbol)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls224_appln_cpc (
  appln_id int(11) NOT NULL DEFAULT '0',
  cpc_class_symbol varchar(19) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  cpc_scheme varchar(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  cpc_version date NOT NULL DEFAULT '9999-12-31',
  cpc_value char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  cpc_position char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  cpc_gener_auth char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id, cpc_class_symbol, cpc_scheme)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls226_person_orig (
  person_orig_id int(11) NOT NULL DEFAULT '0',
  person_id int(11) NOT NULL DEFAULT '0',
  source char(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  source_version varchar(10) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  name_freeform varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  last_name varchar(400) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  first_name varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  middle_name varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  address_freeform varchar(1000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  street varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  city varchar(200) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  zip_code varchar(30) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  state char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  person_ctry_code char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  residence_ctry_code char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  role varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (person_orig_id),
  KEY person_id (person_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls227_pers_publn (
  person_id int(11) NOT NULL DEFAULT '0',
  pat_publn_id int(11) NOT NULL DEFAULT '0',
  applt_seq_nr smallint(6) NOT NULL DEFAULT '0',
  invt_seq_nr smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (person_id,pat_publn_id,applt_seq_nr,invt_seq_nr),
  KEY pat_publn_id (pat_publn_id),
  KEY person_id (person_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls228_docdb_fam_citn (
  docdb_family_id int(11) NOT NULL DEFAULT '0',
  cited_docdb_family_id int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (docdb_family_id,cited_docdb_family_id),
  KEY docdb_family_id (docdb_family_id),
  KEY cited_docdb_family_id (cited_docdb_family_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls229_appln_nace2 (
  appln_id int(11) NOT NULL DEFAULT '0',
  nace2_code char(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  weight float NOT NULL DEFAULT '1',
  PRIMARY KEY (appln_id,nace2_code),
  KEY nace2_code (nace2_code)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls801_country (
  ctry_code varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  iso_alpha3 varchar(3) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  st3_name varchar(100) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  state_indicator char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  continent varchar(25) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  eu_member char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  epo_member char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  oecd_member char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  discontinued char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (ctry_code)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls802_legal_event_code (
  lec_id smallint(6) NOT NULL DEFAULT '0',
  auth_cc varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  lec_name varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  nat_auth_cc varchar(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  nat_lec_name varchar(4) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  impact char(1) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  lec_descr varchar(250) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  lecg_id tinyint(4) NOT NULL DEFAULT '0',
  lecg_name varchar(6) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  lecg_descr varchar(150) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (lec_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls901_techn_field_ipc (
  ipc_maingroup_symbol varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  techn_field_nr tinyint(4) NOT NULL DEFAULT '0',
  techn_sector varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  techn_field varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (techn_field_nr,techn_sector,techn_field,ipc_maingroup_symbol)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls902_ipc_nace2 (
  ipc varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  not_with_ipc varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  unless_with_ipc varchar(8) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  nace2_code char(5) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  nace2_weight float NOT NULL DEFAULT '1',
  nace2_descr varchar(150) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (ipc,not_with_ipc,unless_with_ipc,nace2_code)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ;



CREATE TABLE tls906_person (
  person_id int(11) NOT NULL DEFAULT '0',
  person_name varchar(300) COLLATE utf8_unicode_ci NOT NULL,
  person_address varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  person_ctry_code char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  doc_std_name_id int(11) NOT NULL DEFAULT '0',
  doc_std_name varchar(500) COLLATE utf8_unicode_ci NOT NULL,
  hrm_l2_id int(11) NOT NULL DEFAULT '0',
  hrm_l1 varchar(400) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  hrm_l2 varchar(400) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  hrm_level tinyint(4) NOT NULL DEFAULT '0',
  sector varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  han_id int(11) NOT NULL DEFAULT '0',
  han_name varchar(500) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  han_harmonized int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (person_id),
  KEY IX_ppat_person_ctry_code (person_ctry_code),
  KEY IX_ppat_hrm_l1 (hrm_l1(333)),
  KEY IX_ppat_hrm_l2 (hrm_l2(333)),
  KEY IX_ppat_sector (sector),
  KEY IX_ppat_hrm_l2_id (hrm_l2_id),
  KEY IX_ppat_han_id (han_id),
  KEY IX_han_name (han_name(333)),
  KEY IX_han_harmonized (han_harmonized)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls909_eee_ppat (
  person_id int(11) NOT NULL DEFAULT '0',
  person_ctry_code char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  person_name varchar(400) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  hrm_l1 varchar(400) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  hrm_l2 varchar(400) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  hrm_level tinyint(4) NOT NULL DEFAULT '0',
  hrm_l2_id int(11) NOT NULL DEFAULT '0',
  sector varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  person_address varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  doc_std_name_id int(11) NOT NULL DEFAULT '0',
  pat_cnt int(11) NOT NULL,
  PRIMARY KEY (person_id),
  KEY IX_ppat_person_ctry_code (person_ctry_code),
  KEY IX_ppat_hrm_l1 (hrm_l1(333)),
  KEY IX_ppat_hrm_l2 (hrm_l2(333)),
  KEY IX_ppat_sector (sector),
  KEY IX_ppat_hrm_l2_id (hrm_l2_id)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci  AVG_ROW_LENGTH=100;

EOF
