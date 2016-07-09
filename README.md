# An experiment to compare JSON parsing performance

Just measuring the throughput of JSON parsing in the following programming languages and libraries:

* jq 1.5
* Perl 5.18.2
    * `JSON::XS` 3.02
    * `JSON::PP` 2.27203
* Python
    * Python JSON libraries
        * `json.loads`
        * `ujson` 1.35
        * `simplejson` 3.8.2
    * Python versions
        * CPython 2.7.10
        * CPython 3.5.1
        * PyPy 5.3.1 (+CPython 2.7.10)
* JavaScript node.js 5.9.0
    * `JSON.parse` with `readline`

## Measuring throughputs

To measure all implementations:
```bash
$ make
# citylots.json with parse-json.jq
# citylots.json with parse-json.jq: 0:00:05 [  29MiB/s]
# citylots.json with parse-json-xs.pl
# citylots.json with parse-json-xs.pl: 0:00:05 [56.9MiB/s]
# citylots.json with parse-json-pp.pl
# citylots.json with parse-json-pp.pl: 0:00:05 [1.19MiB/s]
# citylots.json with parse-json-json.py2
# citylots.json with parse-json-json.py2: 0:00:05 [29.2MiB/s]
# citylots.json with parse-json-json.py3
# citylots.json with parse-json-json.py3: 0:00:05 [32.3MiB/s]
# citylots.json with parse-json-json.pypy
# citylots.json with parse-json-json.pypy: 0:00:05 [50.9MiB/s]
# citylots.json with parse-json-ujson.py2
# citylots.json with parse-json-ujson.py2: 0:00:05 [ 110MiB/s]
# citylots.json with parse-json-ujson.py3
# citylots.json with parse-json-ujson.py3: 0:00:05 [91.7MiB/s]
# citylots.json with parse-json-ujson.pypy
# citylots.json with parse-json-ujson.pypy: 0:00:05 [18.3MiB/s]
# citylots.json with parse-json-simplejson.py2
# citylots.json with parse-json-simplejson.py2: 0:00:05 [42.5MiB/s]
# citylots.json with parse-json-simplejson.py3
# citylots.json with parse-json-simplejson.py3: 0:00:05 [29.1MiB/s]
# citylots.json with parse-json-simplejson.pypy
# citylots.json with parse-json-simplejson.pypy: 0:00:05 [17.7MiB/s]

$ make DATA=companies.json
# companies.json with parse-json.jq
# companies.json with parse-json.jq: 0:00:05 [43.6MiB/s]
# companies.json with parse-json-xs.pl
# companies.json with parse-json-xs.pl: 0:00:05 [66.8MiB/s]
# companies.json with parse-json-pp.pl
# companies.json with parse-json-pp.pl: 0:00:05 [1.22MiB/s]
# companies.json with parse-json-json.py2
# companies.json with parse-json-json.py2: 0:00:05 [  39MiB/s]
# companies.json with parse-json-json.py3
# companies.json with parse-json-json.py3: 0:00:05 [63.9MiB/s]
# companies.json with parse-json-json.pypy
# companies.json with parse-json-json.pypy: 0:00:05 [ 142MiB/s]
# companies.json with parse-json-ujson.py2
# companies.json with parse-json-ujson.py2: 0:00:05 [ 126MiB/s]
# companies.json with parse-json-ujson.py3
# companies.json with parse-json-ujson.py3: 0:00:05 [86.7MiB/s]
# companies.json with parse-json-ujson.pypy
# companies.json with parse-json-ujson.pypy: 0:00:05 [32.5MiB/s]
# companies.json with parse-json-simplejson.py2
# companies.json with parse-json-simplejson.py2: 0:00:05 [ 111MiB/s]
# companies.json with parse-json-simplejson.py3
# companies.json with parse-json-simplejson.py3: 0:00:05 [62.7MiB/s]
# companies.json with parse-json-simplejson.pypy
# companies.json with parse-json-simplejson.pypy: 0:00:05 [23.1MiB/s]

$ make DATA=signalmedia-1m.jsonl
# signalmedia-1m.jsonl with parse-json.jq
# signalmedia-1m.jsonl with parse-json.jq: 0:00:05 [94.9MiB/s]
# signalmedia-1m.jsonl with parse-json-xs.pl
# signalmedia-1m.jsonl with parse-json-xs.pl: 0:00:05 [ 266MiB/s]
# signalmedia-1m.jsonl with parse-json-pp.pl
# signalmedia-1m.jsonl with parse-json-pp.pl: 0:00:05 [1.42MiB/s]
# signalmedia-1m.jsonl with parse-json-json.py2
# signalmedia-1m.jsonl with parse-json-json.py2: 0:00:05 [ 106MiB/s]
# signalmedia-1m.jsonl with parse-json-json.py3
# signalmedia-1m.jsonl with parse-json-json.py3: 0:00:05 [ 138MiB/s]
# signalmedia-1m.jsonl with parse-json-json.pypy
# signalmedia-1m.jsonl with parse-json-json.pypy: 0:00:05 [ 105MiB/s]
# signalmedia-1m.jsonl with parse-json-ujson.py2
# signalmedia-1m.jsonl with parse-json-ujson.py2: 0:00:05 [ 278MiB/s]
# signalmedia-1m.jsonl with parse-json-ujson.py3
# signalmedia-1m.jsonl with parse-json-ujson.py3: 0:00:05 [ 212MiB/s]
# signalmedia-1m.jsonl with parse-json-ujson.pypy
# signalmedia-1m.jsonl with parse-json-ujson.pypy: 0:00:05 [ 108MiB/s]
# signalmedia-1m.jsonl with parse-json-simplejson.py2
# signalmedia-1m.jsonl with parse-json-simplejson.py2: 0:00:05 [ 125MiB/s]
# signalmedia-1m.jsonl with parse-json-simplejson.py3
# signalmedia-1m.jsonl with parse-json-simplejson.py3: 0:00:05 [ 129MiB/s]
# signalmedia-1m.jsonl with parse-json-simplejson.pypy
# signalmedia-1m.jsonl with parse-json-simplejson.pypy: 0:00:05 [80.9MiB/s]
```
which also records results as `.throughput` files.

Measurements above are captured from a single shoddy run on a MacBook Pro 15-inch, Mid 2015, 2.5GHz Intel Core i7 running OS X El Capitan 10.11.5 (with a bunch of apps running), so look at the numbers with a grain of salt.

To measure a particular implementation:
```bash
make IMPL=parse-json-xs.pl clean test
```

## Parameters

You can tell which JSON/JSON-lines data to feed as input.
```bash
make DATA=citylots.json
make DATA=signalmedia-1m.jsonl
```

You can adjust how long to run each implementation with `TIMEOUT` parameter.
```bash
make TIMEOUT=1m
make TIMEOUT=30s
```

## See Also
* <http://artem.krylysov.com/blog/2015/09/29/benchmark-python-json-libraries/>
* <http://sck.pm/p0>
* <http://perlmaven.com/comparing-the-speed-of-json-decoders>
