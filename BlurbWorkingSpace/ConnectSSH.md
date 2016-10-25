- WS - The same environment with PROD Link: http://ws.blurb.com/
                                                                      
                                                                      - ssh tle@oak-stage-worker01
                                                                      
                                                                      (MASTER: ssh tle@hq-master-worker01.eng.blurb.com)
                                                                      
                                                                      sudo su - blurbapp
                                                                      
                                                                      cd $PROJ
                                                                      
                                                                      script/console
                                                                      
                                                                      [2:49]  
                                                                      psql -h oak-bi-postgres02.blurb.com -d blurb_production -U my_username