```ruby
Net::SSH.start("oak-stage-worker01", "tle", :password => "LeHuuT@i181")  do |ssh|
  result = ssh.exec!("echo $PATH")
  puts result
end


Net::SSH.start("oak-stage-worker01", "tle", :password => "LeHuuT@i181")  do |ssh|
  ssh.forward.remote(80, "www.google.com", 1234)
  ssh.loop { true }
end

cheat_code = "/data/paypal/20140318/AUD/STL-20140318.01.002.CSV"

 {:USD=>{:login=>"seller_1240336672_biz_api1.blurb.com", :password=>"B5E8BZ4SEA3XC2EJ", :cert_file=>"/data/apps/blurby/current/config/crt/test/usd_paypal_cert_sandbox.txt", :sftp_user=>"sftpan_paypal_usdblurb.com", :sftp_password=>"B00kB00t$"}, :EUR=>{:login=>"eu_sel_1243030416_biz_api1.blurb.com", :password=>"A89YJFD243397NSC", :cert_file=>"/data/apps/blurby/current/config/crt/test/eur_paypal_cert_sandbox.txt", :sftp_user=>"sftpA8_paypal_eurblurb.com", :sftp_password=>"B00kB00t$"}, :GBP=>{:login=>"uk_sel_1243032792_biz_api1.blurb.com", :password=>"5KRDD3NXQKT7B869", :cert_file=>"/data/apps/blurby/current/config/crt/test/gbp_paypal_cert_sandbox.txt", :sftp_user=>"sftpJC_paypal_gbpblurb.com", :sftp_password=>"B00kB00t$"}, :AUD=>{:login=>"aud_1249596025_biz_api1.blurb.com", :password=>"6NQT56USE3SCZCRM", :cert_file=>"/data/apps/blurby/current/config/crt/test/aud_paypal_cert_sandbox.txt", :sftp_user=>"sftpa5_paypal-audblurb.com", :sftp_password=>"B00kB00t$"}, :CAD=>{:login=>"cad_1268248379_biz_api1.blurb.com", :password=>"FSGAG5E9V6R9NU8K", :cert_file=>"/data/apps/blurby/current/config/crt/test/cad_paypal_cert_sandbox.txt", :sftp_user=>"sftpI3_paypal-cadblurb.com", :sftp_password=>"B00kB00t$"}}

```