##Staging WS.blurb.com
- WS - The same environment with PROD Link: http://ws.blurb.com/
- ssh tle@oak-stage-worker01
- psql -h  oak-stage-db01.blurb.com -U blurby  -d blurb_staging (MR.fred)

- db master unknown

##Production
- ssh tle@hq-master-worker01.eng.blurb.com
- psql -h hq-master-db01.eng.blurb.com -U blurby -d blurb_staging (MR.fred)
psql -h oak-bi-postgres02.blurb.com -d blurb_production -U tle
web env

[11:06]  
- prod: blurb.com

[11:06]  
- staging: ws.blurb.com

[11:06]  
- master: master.eng.blurb.com

[11:07]  
db:

[11:08]  
- prod (read only): oak-bi-postgres02

[11:08]  
- master: unknow

[11:08]  
server (ssh):

[11:09]  
- ws: ssh <username>@oak-stage-worker01

[11:09]  
- master: ssh <username>@hq-master-worker01.eng.blurb.com
- master: ssh tle@hq-master-worker01.eng.blurb.com

[11:10]  
ex: ssh tle@oak-stage-worker01

[11:10]  
sudo su - blurbapp

[11:10]  
cd $PROJ

[11:12]  
log: