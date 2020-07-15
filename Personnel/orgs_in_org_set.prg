/* List orgs associated with an org set */
select os.name
     , os.description
     , org.org_name
;     , ORG_TYPE=cvorgtype.display
     , org.*
;     , ospr.*
from org_set os
, (inner join org_set_org_r osor
           on osor.org_set_id = os.org_set_id
          and os.active_ind = 1
          and os.end_effective_dt_tm > sysdate)
, (inner join organization org
            on org.organization_id = osor.organization_id
           and org.active_ind = 1
           and org.end_effective_dt_tm > sysdate)
/* Orgs that a personnel is attached to */
/* Uncomment if you only want to show orgs in org set */
;, (inner join org_set_prsnl_r ospr
;            on ospr.org_set_id = os.org_set_id
;           and ospr.active_ind = 1
;           and ospr.end_effective_dt_tm > sysdate)
;, (inner join code_value cvorgtype
;           on cvorgtype.code_value = ospr.org_set_type_cd
;          and cvorgtype.active_ind = 1
;          and cvorgtype.code_set = 28881)
where os.name = 'ALL ORGS'
;  and ospr.prsnl_id = 8531805.00
order by os.name,os.description, org.org_name
go
