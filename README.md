## Useful commands

## Monitor with CLI

```bash
rails s
script/puma_stats
```


### Monitor with StatsD

```bash
ruby script/statsd_server.rb
STATSD_HOST=127.0.0.1 rails s
```


