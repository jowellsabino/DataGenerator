/* Personnel alias pools and organization association */
select Alias_Pool=cvaliaspool.display
      , org.org_name
      , Prsnl_Alias_Type=cvaliasentity.display
      , orgrel.*
from organization org
, (inner join org_alias_pool_reltn orgrel
           on orgrel.organization_id = org.organization_id
          and orgrel.alias_entity_name = 'PRSNL_ALIAS') /* Specific to prsnl aliases */
, (inner join code_value cvaliaspool
           on cvaliaspool.code_value = orgrel.alias_pool_cd
          and cvaliaspool.active_ind = 1
          and cvaliaspool.code_set = 263)
, (inner join code_value cvaliasentity
           on cvaliasentity.code_value = orgrel.alias_entity_alias_type_cd
          and cvaliasentity.active_ind = 1
          and cvaliasentity.code_set = 320) /* Specific to prsnl aliases only */
where org.active_ind = 1
  and org.end_effective_dt_tm > sysdate 
  /* alias pools we are interested in */
  and cvaliaspool.display_key in ( 'CHBEPDS'
                                  ,'CHBBADGENUMBER'
                                  ,'CHBSURESCRIPTS')
  /* Org associated with the alias pool - comment out to get all orgs associated */
  ;and org.org_name_key = 'BOSTONCHILDRENSHOSPITAL*'
order by 
        cvaliaspool.display
      , org.org_name
      , cvaliasentity.display
go


