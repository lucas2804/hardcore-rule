##Staging WS.blurb.com
- WS - The same environment with PROD Link: http://ws.blurb.com/
- ssh tle@oak-stage-worker01
- psql -h  oak-stage-db01.blurb.com -U blurby  -d blurb_staging (MR.fred)

##Production
- ssh tle@hq-master-worker01.eng.blurb.com
- psql -h hq-master-db01.eng.blurb.com -U blurby -d blurb_staging (MR.fred)
psql -h oak-bi-postgres02.blurb.com -d blurb_production -U tle
ill b