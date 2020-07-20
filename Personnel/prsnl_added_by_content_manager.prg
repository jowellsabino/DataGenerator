/* updt_task is distinctively set to 4170142 for prsnl added by Content Mnager */
select *
from prsnl pr
where pr.updt_dt_tm > sysdate - 5 ;pr.username in ('DGMD1','DGMD2','DGMD3','DGMD4')
and pr.updt_task = 4170142
go

/* AuthView touches ea_user only */
select *
from ea_user eau
where eau.username in ('DGMD1','DGMD2','DGMD3','DGMD4')
with format(date,";;q")
go