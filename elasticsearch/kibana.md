####1- Run Kibana
1) Run
```
alias kibana="/Users/luc/Downloads/kibana-4.6.1-darwin-x86_64/bin/kibana ; exit;"
```

2) Changing the Kibana configuration

```
sudo vi /Users/luc/Downloads/kibana-4.6.1-darwin-x86_64/config/kibana.yml
```

3) Install elasticdump to import sample data(JSON)
```
npm install  elasticdump@2.0.0 -g 

elasticdump --bulk=true --input="./Kibana_Essentials/tweet.json" --output=http://localhost:9200
```

4) Install Sense as postman
```
cd path/to/kibana-4.6.1
./bin/kibana plugin --install elastic/sense
```