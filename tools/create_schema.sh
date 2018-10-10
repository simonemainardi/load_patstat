if [[ $# != 2 ]]
then
    echo "Usage: $0 <database_name> <engine>"
    exit 1
fi

DBNAME=$1
ENGINE=$2
if [[ $ENGINE == "innodb" ]]; then
   ROW_FORMAT="ROW_FORMAT=COMPRESSED"
fi

cat <<EOF
CREATE DATABASE IF NOT EXISTS $DBNAME DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE $DBNAME;

CREATE TABLE tls201_appln (
  appln_id int(11) NOT NULL DEFAULT '0',
  appln_auth char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  appln_nr varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  appln_kind char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '00',
  appln_filing_date date NOT NULL DEFAULT '9999-12-31',
  appln_filing_year smallint NOT NULL DEFAULT '9999',
  appln_nr_epodoc varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  appln_nr_original varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  ipr_type char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  receiving_office char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  internat_appln_id int(11) NOT NULL DEFAULT '0',
  int_phase varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  reg_phase varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  nat_phase varchar(11) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  earliest_filing_date date NOT NULL DEFAULT '9999-12-31',
  earliest_filing_year smallint NOT NULL DEFAULT '9999',
  earliest_filing_id int NOT NULL DEFAULT '0',
  earliest_publn_date date NOT NULL DEFAULT '9999-12-31',
  earliest_publn_year smallint NOT NULL DEFAULT '9999',
  earliest_pat_publn_id int NOT NULL DEFAULT '0',
  granted char(1) NOT NULL DEFAULT 'N',
  docdb_family_id int NOT NULL DEFAULT '0',
  inpadoc_family_id int NOT NULL DEFAULT '0',
  docdb_family_size smallint NOT NULL default '0',
  nb_citing_docdb_fam smallint NOT NULL default '0',
  nb_applicants smallint NOT NULL default '0',
  nb_inventors smallint NOT NULL default '0',
  PRIMARY KEY (appln_id),
  KEY IX_internat_appln_id (internat_appln_id),
  KEY IX_appln_auth (appln_auth,appln_nr,appln_kind),
  KEY IX_appln_filing_date (appln_filing_date),
  KEY IX_appln_kind (appln_kind),
  KEY IX_docdb_family_id (docdb_family_id),
  KEY IX_inpadoc_family_id (inpadoc_family_id),
  KEY IX_docdb_family_id_filing_date (docdb_family_id,appln_filing_date),
  KEY IX_inpadoc_family_id_filing_date (inpadoc_family_id,appln_filing_date)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls202_appln_title (
  appln_id int(11) NOT NULL DEFAULT '0',
  appln_title_lg char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  appln_title text COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (appln_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=600;



CREATE TABLE tls203_appln_abstr (
  appln_id int(11) NOT NULL DEFAULT '0',
  appln_abstract_lg char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  appln_abstract text COLLATE utf8mb4_unicode_ci,
  PRIMARY KEY (appln_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=800;



CREATE TABLE tls204_appln_prior (
  appln_id int(11) NOT NULL DEFAULT '0',
  prior_appln_id int(11) NOT NULL DEFAULT '0',
  prior_appln_seq_nr smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (appln_id,prior_appln_id),
  KEY IX_prior_appln_id (prior_appln_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=800;



CREATE TABLE tls205_tech_rel (
  appln_id int(11) NOT NULL DEFAULT '0',
  tech_rel_appln_id int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (appln_id,tech_rel_appln_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls206_person (
  person_id int(11) NOT NULL DEFAULT '0',
  person_name varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  person_address varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  person_ctry_code char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  doc_std_name_id int(11) NOT NULL DEFAULT '0',
  doc_std_name varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  psn_id int(11) NOT NULL DEFAULT '0',
  psn_name varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  psn_level smallint NOT NULL DEFAULT '0',
  psn_sector varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (person_id),
  KEY IX_person_ctry_code (person_ctry_code),
  KEY IX_doc_std_name_id (doc_std_name_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls207_pers_appln (
  person_id int(11) NOT NULL DEFAULT '0',
  appln_id int(11) NOT NULL DEFAULT '0',
  applt_seq_nr smallint(6) NOT NULL DEFAULT '0',
  invt_seq_nr smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (person_id,appln_id,applt_seq_nr,invt_seq_nr),
  KEY IX_person_id (person_id),
  KEY IX_appln_id (appln_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls209_appln_ipc (
  appln_id int(11) NOT NULL DEFAULT '0',
  ipc_class_symbol varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  ipc_class_level char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  ipc_version date NOT NULL DEFAULT '9999-12-31',
  ipc_value char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  ipc_position char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  ipc_gener_auth char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,ipc_class_symbol,ipc_class_level),
  KEY IX_ipc_class_symbol (ipc_class_symbol)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls210_appln_n_cls (
  appln_id int(11) NOT NULL DEFAULT '0',
  nat_class_symbol varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,nat_class_symbol)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls211_pat_publn (
  pat_publn_id int(11) NOT NULL DEFAULT '0',
  publn_auth char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  publn_nr varchar(15) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  publn_nr_original varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  publn_kind char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  appln_id int(11) NOT NULL DEFAULT '0',
  publn_date date NOT NULL DEFAULT '9999-12-31',
  publn_lg char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  publn_first_grant char(1) NOT NULL DEFAULT 'N',
  publn_claims smallint(6) DEFAULT NULL,
  PRIMARY KEY (pat_publn_id),
  KEY IX_publn_auth (publn_auth,publn_nr,publn_kind),
  KEY IX_appln_id (appln_id),
  KEY IX_publn_date (publn_date),
  KEY IX_publ_lg (publn_lg)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls212_citation (
  pat_publn_id int(11) NOT NULL DEFAULT '0',
  citn_replenished int NOT NULL DEFAULT '0',
  citn_id smallint(6) NOT NULL DEFAULT '0',
  citn_origin char(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  cited_pat_publn_id int(11) NOT NULL DEFAULT '0',
  cited_appln_id int(10) unsigned NOT NULL DEFAULT '0',
  pat_citn_seq_nr smallint(6) NOT NULL DEFAULT '0',
  cited_npl_publn_id int(11) NOT NULL DEFAULT '0',
  npl_citn_seq_nr smallint(6) NOT NULL DEFAULT '0',
  citn_gener_auth char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (pat_publn_id,citn_replenished,citn_id),
  KEY IX_cited_pat_publn_id (cited_pat_publn_id),
  KEY cited_appln_id (cited_appln_id,pat_publn_id),
  KEY IX_pat_citn_seq_nr (pat_citn_seq_nr),
  KEY IX_npl_citn_seq_nr (npl_citn_seq_nr),
  KEY IX_cited_npl_publn_id (cited_npl_publn_id),
  KEY IX_cited_pub_seq_nr (cited_pat_publn_id,pat_citn_seq_nr),
  KEY IX_cited_app_seq_nr (cited_appln_id,pat_citn_seq_nr)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  PACK_KEYS=0;



CREATE TABLE tls214_npl_publn (
  npl_publn_id int(11) NOT NULL DEFAULT '0',
  npl_type char(1) NOT NULL DEFAULT '',
  npl_biblio longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  npl_author nvarchar(1000) NOT NULL DEFAULT '',
  npl_title1 nvarchar(1000) NOT NULL DEFAULT '',
  npl_title2 nvarchar(1000) NOT NULL DEFAULT '',
  npl_editor nvarchar(500) NOT NULL DEFAULT '',
  npl_volume varchar(50) NOT NULL DEFAULT '',
  npl_issue varchar(50) NOT NULL DEFAULT '',
  npl_publn_date varchar(8) NOT NULL DEFAULT '',
  npl_publn_end_date varchar(8) NOT NULL DEFAULT '',
  npl_publisher nvarchar(500) NOT NULL DEFAULT '',
  npl_page_first varchar(200) NOT NULL DEFAULT '',
  npl_page_last varchar(200) NOT NULL DEFAULT '',
  npl_abstract_nr varchar(50) NOT NULL DEFAULT '',
  npl_doi varchar(500) NOT NULL DEFAULT '',
  npl_isbn varchar(30) NOT NULL DEFAULT '',
  npl_issn varchar(30) NOT NULL DEFAULT '',
  online_availability varchar(500) NOT NULL DEFAULT '',
  online_classification varchar(35) NOT NULL DEFAULT '',
  online_search_date varchar(8) NOT NULL DEFAULT '',
  PRIMARY KEY (npl_publn_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=150;



CREATE TABLE tls215_citn_categ (
  pat_publn_id int(11) NOT NULL DEFAULT '0',
  citn_replenished int NOT NULL DEFAULT '0',
  citn_id smallint(6) NOT NULL DEFAULT '0',
  citn_categ char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (pat_publn_id,citn_replenished,citn_id,citn_categ)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls216_appln_contn (
  appln_id int(11) NOT NULL DEFAULT '0',
  parent_appln_id int(11) NOT NULL DEFAULT '0',
  contn_type char(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,parent_appln_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;


CREATE TABLE tls231_inpadoc_legal_event (
  event_id int NOT NULL DEFAULT '0',
  appln_id int(11) NOT NULL DEFAULT '0',
  event_seq_nr smallint(6) NOT NULL DEFAULT '0',
  event_type char(3) NOT NULL DEFAULT '  ',
  event_auth char(2) NOT NULL DEFAULT '  ',
  event_code varchar(4)  NOT NULL DEFAULT '',
	event_filing_date date NOT NULL DEFAULT '9999-12-31',
  event_publn_date date NOT NULL DEFAULT '9999-12-31',
  event_effective_date date NOT NULL DEFAULT '9999-12-31',
  event_text varchar(1000) NOT NULL DEFAULT '',
  ref_doc_auth char(2) NOT NULL DEFAULT '  ',
  ref_doc_nr varchar(20) NOT NULL DEFAULT '',
  ref_doc_kind char(2) NOT NULL DEFAULT '  ',
  ref_doc_date date NOT NULL DEFAULT '9999-12-31',
  ref_doc_text varchar(1000) NOT NULL DEFAULT '',
  party_type varchar(3) NOT NULL DEFAULT '   ',
  party_seq_nr smallint NOT NULL default '0',
  party_new varchar(1000) NOT NULL DEFAULT '',
  party_old varchar(1000) NOT NULL DEFAULT '',
  spc_nr varchar(40) NOT NULL DEFAULT '',
  spc_filing_date date NOT NULL DEFAULT '9999-12-31',
  spc_patent_expiry_date date NOT NULL DEFAULT '9999-12-31',
  spc_extension_date date NOT NULL DEFAULT '9999-12-31',
  spc_text varchar(1000) NOT NULL DEFAULT '',
  designated_states varchar(1000) NOT NULL DEFAULT '',
  extension_states varchar(30) NOT NULL DEFAULT '',
  fee_country char(2) NOT NULL DEFAULT '  ',
  fee_payment_date date NOT NULL DEFAULT '9999-12-31',
  fee_renewal_year smallint NOT NULL default '9999',
  fee_text varchar(1000) NOT NULL DEFAULT '',
  lapse_country char(2) NOT NULL DEFAULT '  ',
  lapse_date date NOT NULL DEFAULT '9999-12-31',
  lapse_text varchar(1000) NOT NULL DEFAULT '',
  reinstate_country char(2) NOT NULL DEFAULT '  ',
  reinstate_date date NOT NULL DEFAULT '9999-12-31',
  reinstate_text varchar(1000) NOT NULL DEFAULT '',
  class_scheme varchar(4) NOT NULL DEFAULT '',
  class_symbol varchar(50) NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,event_seq_nr),
  KEY event_publn_date (event_publn_date,appln_id),
  KEY event_type (event_type,appln_id),
  KEY event_code (event_code,appln_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls222_appln_jp_class (
  appln_id int(11) NOT NULL DEFAULT '0',
  jp_class_scheme varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  jp_class_symbol varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,jp_class_scheme,jp_class_symbol),
  KEY jp_class_symbol (jp_class_symbol,jp_class_scheme)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls223_appln_docus (
  appln_id int(11) NOT NULL DEFAULT '0',
  docus_class_symbol varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id,docus_class_symbol),
  KEY docus_class_symbol (docus_class_symbol)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls224_appln_cpc (
  appln_id int(11) NOT NULL DEFAULT '0',
  cpc_class_symbol varchar(19) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  cpc_scheme varchar(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  cpc_version date NOT NULL DEFAULT '9999-12-31',
  cpc_value char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  cpc_position char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  cpc_gener_auth char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (appln_id, cpc_class_symbol, cpc_scheme)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls226_person_orig (
  person_orig_id int(11) NOT NULL DEFAULT '0',
  person_id int(11) NOT NULL DEFAULT '0',
  source char(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  source_version varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  name_freeform varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  last_name varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  first_name varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  middle_name varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  address_freeform varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  address_1 varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  address_2 varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  address_3 varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  address_4 varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  address_5 varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  street varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  city varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  zip_code varchar(30) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  state char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  person_ctry_code char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  residence_ctry_code char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  role varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (person_orig_id),
  KEY person_id (person_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls227_pers_publn (
  person_id int(11) NOT NULL DEFAULT '0',
  pat_publn_id int(11) NOT NULL DEFAULT '0',
  applt_seq_nr smallint(6) NOT NULL DEFAULT '0',
  invt_seq_nr smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (person_id,pat_publn_id,applt_seq_nr,invt_seq_nr),
  KEY pat_publn_id (pat_publn_id),
  KEY person_id (person_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls228_docdb_fam_citn (
  docdb_family_id int(11) NOT NULL DEFAULT '0',
  cited_docdb_family_id int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (docdb_family_id,cited_docdb_family_id),
  KEY docdb_family_id (docdb_family_id),
  KEY cited_docdb_family_id (cited_docdb_family_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls229_appln_nace2 (
  appln_id int(11) NOT NULL DEFAULT '0',
  nace2_code char(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  weight float NOT NULL DEFAULT '1',
  PRIMARY KEY (appln_id,nace2_code),
  KEY nace2_code (nace2_code)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls230_appln_techn_field (
  appln_id int(11) NOT NULL DEFAULT '0',
  techn_field_nr tinyint NOT NULL DEFAULT '0',
  weight float NOT NULL DEFAULT '1',
  PRIMARY KEY (appln_id,techn_field_nr)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls801_country (
  ctry_code varchar(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  iso_alpha3 varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  st3_name varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  state_indicator char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  continent varchar(25) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  eu_member char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  epo_member char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  oecd_member char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  discontinued char(1) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (ctry_code)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=100;


CREATE TABLE tls803_legal_event_code (
  event_auth char(2) NOT NULL DEFAULT '',
  event_code varchar(4) NOT NULL DEFAULT '',
  event_impact char(1) NOT NULL DEFAULT '',
  event_descr varchar(250) NOT NULL DEFAULT '',
  event_descr_orig varchar(250) NOT NULL DEFAULT '',
  event_category_code char(1) NOT NULL DEFAULT '',
  event_category_title varchar(100) NOT NULL DEFAULT ''
  PRIMARY KEY (event_auth, event_code)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls901_techn_field_ipc (
  ipc_maingroup_symbol varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  techn_field_nr tinyint(4) NOT NULL DEFAULT '0',
  techn_sector varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  techn_field varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (techn_field_nr,techn_sector,techn_field,ipc_maingroup_symbol)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls902_ipc_nace2 (
  ipc varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  not_with_ipc varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  unless_with_ipc varchar(8) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  nace2_code char(5) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  nace2_weight float NOT NULL DEFAULT '1',
  nace2_descr varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (ipc,not_with_ipc,unless_with_ipc,nace2_code)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls904_nuts (
  nuts varchar(5) NOT NULL,
  nuts_level int NOT NULL DEFAULT '0',
  nuts_label varchar(250) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (nuts)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ;



CREATE TABLE tls906_person (
  person_id int(11) NOT NULL DEFAULT '0',
  person_name varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  person_address varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  person_ctry_code char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  nuts char(5) NOT NULL DEFAULT '',
  nuts_level smallint  NOT NULL DEFAULT '9',
  doc_std_name_id int(11) NOT NULL DEFAULT '0',
  doc_std_name varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  psn_id int(11) NOT NULL DEFAULT '0',
  psn_name varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  psn_level tinyint(4) NOT NULL DEFAULT '0',
  psn_sector varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  han_id int(11) NOT NULL DEFAULT '0',
  han_name varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  han_harmonized int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (person_id),
  KEY IX_ppat_person_ctry_code (person_ctry_code),
  KEY IX_ppat_nuts (nuts),
  KEY IX_ppat_psn_name (psn_name(250)),
  KEY IX_ppat_psn_sector (psn_sector),
  KEY IX_ppat_psn_id (psn_id),
  KEY IX_ppat_han_id (han_id),
  KEY IX_han_name (han_name(250)),
  KEY IX_han_harmonized (han_harmonized)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=100;



CREATE TABLE tls909_eee_ppat (
  person_id int(11) NOT NULL DEFAULT '0',
  person_ctry_code char(2) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  person_name varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  hrm_l1 varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  hrm_l2 varchar(400) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  hrm_level tinyint(4) NOT NULL DEFAULT '0',
  hrm_l2_id int(11) NOT NULL DEFAULT '0',
  sector varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  person_address varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  doc_std_name_id int(11) NOT NULL DEFAULT '0',
  pat_cnt int(11) NOT NULL,
  PRIMARY KEY (person_id),
  KEY IX_ppat_person_ctry_code (person_ctry_code),
  KEY IX_ppat_hrm_l1 (hrm_l1(333)),
  KEY IX_ppat_hrm_l2 (hrm_l2(333)),
  KEY IX_ppat_sector (sector),
  KEY IX_ppat_hrm_l2_id (hrm_l2_id)
) ENGINE=${ENGINE} $ROW_FORMAT DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci  AVG_ROW_LENGTH=100;

EOF
