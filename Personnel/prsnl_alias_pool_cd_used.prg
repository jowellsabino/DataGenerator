/* Personnel alias pools and organization association */
select org.org_name
      , cvaliaspool.display
      , orgrel.*
from organization org
, (inner join org_alias_pool_reltn orgrel
           on orgrel.organization_id = org.organization_id)
, (inner join code_value cvaliaspool
           on cvaliaspool.code_value = orgrel.alias_pool_cd
          and cvaliaspool.code_set = 263)
where org.org_name_key = 'BOSTONCHILDRENSHOSPITAL' 
  and cvaliaspool.display_key in ( 'CHBEPDS'
                                  ,'CHBBADGENUMBER')
go