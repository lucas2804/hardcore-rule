##Master server
- SSH: ssh tle@oak-stage-worker01
    1) password: LeHuuT@i181
    2) sudo su - blurbapp
    3) cd $PROJ
- Database: psql -h hq-master-db01.eng.blurb.com -U blurby -d blurb_staging 
    1) password: fred

##Production server

- psql -h oak-bi-postgres02.blurb.com -d blurb_production -U tle

o = Order.find 1128241
so = o.shippable_sub_orders.first
so.shipped_to
so.matched_holding_bin_rules.first.holding_bin_rule





