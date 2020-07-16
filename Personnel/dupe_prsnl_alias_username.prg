/* check for dupes -- look for an alias with the same prsnl_alias_type_cd, get username  */
select cvaliaspool.display
     , pra.alias
     , pr.username
     , pra.*
from prsnl pr
, (left join prsnl_alias pra
           on pra.person_id = pr.person_id)
, (left join code_value cvaliaspool
           on cvaliaspool.code_value = pra.alias_pool_cd)
where pra.prsnl_alias_type_cd = (select code_value
                                   from code_value
                                  where code_set = 320
                                    and cdf_meaning = 'PRSNLID')                                   
and pra.alias = '121199';'8900*'
go