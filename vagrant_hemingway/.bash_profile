
# Setting PATH for Python 3.4
# The orginal version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.4/bin:${PATH}"
export PATH=$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# General
alias viBash="vi ~/.bash_profile"
alias cdBlurby="cd ~/ruby/ruby_projects/infonam/blurby"
alias reloadBash=". ~/.bash_profile"

#Blurby
alias suser="sudo su - blurbapp"
alias runServer="cd /vagrant/blurby; bundle exec thin start"
alias migrateEvil="bundle exec rake evil_migration"
alias thinStart="bundle exec thin start"
alias switch3000="sudo iptables -t nat -I PREROUTING -p tcp --dport 80 -j REDIRECT --to-port 3000"
alias ipBlurby="ifconfig eth1 | grep 'inet addr:' | cut -d: -f2 | awk '{ print $1}'

alias viHosts="sudo vi /private/etc/hosts"
alias listShards="curl 'localhost:9200/_cat/shards?v'"

#cd project
alias cdDocument="cd ~/ruby/ruby_projects/miracle/BDDRailsV1/app/models"
alias cdInfonam="cd ~/ruby/ruby_projects/infonam"
alias cdMiracle="cd ~/ruby/ruby_projects/miracle"

#PostgreSQL
alias viTrust="sudo vi /Library/PostgreSQL/9.6/data/pg_hba.conf"
alias listPostgre="ps auxwww | grep postgres"
alias certificatePostgre="ALTER USER postgres with password 'postgres';"
alias connectPsql="psql -U postgres"

#Kibana for elasticsearch
alias kibana="/Users/luc/Downloads/kibana-4.6.1-darwin-x86_64/bin/kibana ; exit;"







