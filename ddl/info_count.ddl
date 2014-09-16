-- -*- mode: sql -*-


replace into `info` set name='tls201_appln.count.count', kind=1, value=(select count(*) from `tls201_appln`);
replace into `info` set name='tls202_appln_title.count', kind=1, value=(select count(*) from `tls202_appln_title`);
replace into `info` set name='tls203_appln_abstr.count', kind=1, value=(select count(*) from `tls203_appln_abstr`);
replace into `info` set name='tls204_appln_prior.count', kind=1, value=(select count(*) from `tls204_appln_prior`);
replace into `info` set name='tls205_tech_rel.count', kind=1, value=(select count(*) from `tls205_tech_rel`);
replace into `info` set name='tls206_person.count', kind=1, value=(select count(*) from `tls206_person`);
replace into `info` set name='tls207_pers_appln.count', kind=1, value=(select count(*) from `tls207_pers_appln`);
replace into `info` set name='tls208_doc_str_nms.count', kind=1, value=(select count(*) from `tls208_doc_std_nms`);
replace into `info` set name='tls209_appln_ipc.count', kind=1, value=(select count(*) from  `tls209_appln_ipc`);
replace into `info` set name='tls210_appln_n_cls.count', kind=1, value=(select count(*) from `tls210_appln_n_cls`);
replace into `info` set name='tls211_pat_publn.count', kind=1, value=(select count(*) from  `tls211_pat_publn`);
replace into `info` set name='tls212_citation.count', kind=1, value=(select count(*) from `tls212_citation`);
replace into `info` set name='tls214_npl_publn.count', kind=1, value=(select count(*) from `tls214_npl_publn`);
replace into `info` set name='tls215_citn_categ.count', kind=1, value=(select count(*) from `tls215_citn_categ`);
replace into `info` set name='tls216_appln_contn.count', kind=1, value=(select count(*) from `tls216_appln_contn`);
replace into `info` set name='tls217_appln_i_cls.count', kind=1, value=(select count(*) from `tls217_appln_i_cls`);
replace into `info` set name='tls218_docdb_fam.count', kind=1, value=(select count(*) from `tls218_docdb_fam`);
replace into `info` set name='tls219_inpadoc_fam.count', kind=1, value=(select count(*) from `tls219_inpadoc_fam`);


replace into `info`
set
name = "tls202_appln_title.appln_title.max_length",
kind = 1,
value = (select max(length(appln_title)) from tls202_appln_title);

replace into `info`
set
name = "tls202_appln_title.appln_title.avg_length",
kind = 1,
value = (select avg(length(appln_title)) from tls202_appln_title);

replace into `info`
set
name = "tls202_appln_abstr.appln_abstract.max_length",
kind = 1,
value = (select max(length(appln_abstract)) from tls203_appln_abstr);

replace into `info`
set
name = "tls202_appln_abstr.appln_abstract.avg_length",
kind = 1,
value = (select avg(length(appln_abstract)) from tls203_appln_abstr);
