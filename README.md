# Monitoring
Simple monitoring with grafana

Configure urls to monitoring.conf

Fix paths to doMonitor.sh 

Add cronjob:
```
* * * * * bash path/to/doMonitor.sh > /dev/null 2>&1
```

Install grafana 

Configure PSQL datasource

Import dashboard
